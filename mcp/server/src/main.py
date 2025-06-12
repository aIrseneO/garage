import asyncio
from typing import Any
import httpx
import logging
from datetime import datetime
from mcp.server.fastmcp import FastMCP
from prometheus_client import start_http_server, Counter

from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn

from fastapi.middleware.cors import CORSMiddleware

import signal
import sys

alerts_counter = Counter('weather_alerts_total', 'Total alert requests')
forecast_counter = Counter('weather_forecasts_total', 'Total forecast requests')

# Constants
NWS_API_BASE = "https://api.weather.gov"
USER_AGENT = "weather-app/1.0"

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Initialize FastMCP server for Weather tools (SSE)
mcp = FastMCP(
    name = "weather",

    # Server settings
    debug = True,
    # Literal["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"]
    log_level = "DEBUG",

    # HTTP settings
    host = "0.0.0.0",
    port = 8000,

    # resource settings
    warn_on_duplicate_resources = True,

    # tool settings
    warn_on_duplicate_tools = True,

    # prompt settings
    warn_on_duplicate_prompts = True,
    
    # Add SSE-specific settings
    sse_ping_interval=30,  # Ping every 30 seconds instead of 15
    sse_reconnect_timeout=45,  # Longer timeout for reconnection
)

# Create FastAPI app
app = FastAPI(title="Weather API", description="Simple HTTP API for weather tools")

# Add CORS middleware to your FastAPI app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Be more restrictive in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Graceful shutdown handler
def signal_handler(sig, frame):
    logger.info('Shutting down gracefully...')
    # Close any active connections here if needed
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

class ForecastRequest(BaseModel):
    latitude: float
    longitude: float

class AlertsRequest(BaseModel):
    state: str

async def make_nws_request(url: str) -> dict[str, Any] | None:
    """Make a request to the NWS API with proper error handling."""
    logger.info(f"Making NWS API request to: {url}")
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/geo+json"
    }
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(url, headers=headers, timeout=30.0)
            response.raise_for_status()
            logger.info(f"NWS API request successful: {response.status_code}")
            return response.json()
        except Exception as e:
            logger.error(f"NWS API request failed: {e}")
            return None

def format_alert(feature: dict) -> str:
    """Format an alert feature into a readable string."""
    props = feature["properties"]
    return f"""
Event: {props.get('event', 'Unknown')}
Area: {props.get('areaDesc', 'Unknown')}
Severity: {props.get('severity', 'Unknown')}
Description: {props.get('description', 'No description available')}
Instructions: {props.get('instruction', 'No specific instructions provided')}
"""

# Add health endpoint
@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy", 
        "timestamp": datetime.now().isoformat(),
        "server": "weather-mcp"
    }

@mcp.tool()
async def get_alerts(state: str) -> str:
    """Get weather alerts for a US state.
    Args:
        state: Two-letter US state code (e.g. CA, NY)
    """
    alerts_counter.inc()
    logger.info(f"🚨 get_alerts called for state: {state}")
    print(f"[{datetime.now().strftime('%H:%M:%S')}] 🚨 Getting weather alerts for state: {state}")
    
    url = f"{NWS_API_BASE}/alerts/active/area/{state}"
    data = await make_nws_request(url)

    if not data or "features" not in data:
        result = "Unable to fetch alerts or no alerts found."
        logger.warning(f"No alerts data found for state: {state}")
        print(f"[{datetime.now().strftime('%H:%M:%S')}] ⚠️  No alerts found for {state}")
        return result

    if not data["features"]:
        result = "No active alerts for this state."
        logger.info(f"No active alerts for state: {state}")
        print(f"[{datetime.now().strftime('%H:%M:%S')}] ✅ No active alerts for {state}")
        return result

    alerts = [format_alert(feature) for feature in data["features"]]
    result = "\n---\n".join(alerts)
    logger.info(f"Found {len(alerts)} alerts for state: {state}")
    print(f"[{datetime.now().strftime('%H:%M:%S')}] 📋 Found {len(alerts)} alerts for {state}")
    return result

@app.post("/api/alerts")
async def api_get_alerts(request: AlertsRequest):
    """Get weather alerts for a state"""
    try:
        result = await get_alerts(request.state)
        return {"success": True, "data": result}
    except Exception as e:
        return {"success": False, "error": str(e)}

@mcp.tool()
async def get_forecast(latitude: float, longitude: float) -> str:
    """Get weather forecast for a location.
    Args:
        latitude: Latitude of the location
        longitude: Longitude of the location
    """
    forecast_counter.inc()
    logger.info(f"🌤️  get_forecast called for coordinates: {latitude}, {longitude}")
    print(f"[{datetime.now().strftime('%H:%M:%S')}] 🌤️  Getting forecast for: {latitude}, {longitude}")
    
    # First get the forecast grid endpoint
    points_url = f"{NWS_API_BASE}/points/{latitude},{longitude}"
    points_data = await make_nws_request(points_url)

    if not points_data:
        result = "Unable to fetch forecast data for this location."
        logger.error(f"Failed to fetch points data for coordinates: {latitude}, {longitude}")
        print(f"[{datetime.now().strftime('%H:%M:%S')}] ❌ Failed to fetch points data for {latitude}, {longitude}")
        return result

    # Get the forecast URL from the points response
    forecast_url = points_data["properties"]["forecast"]
    logger.info(f"Fetching forecast from: {forecast_url}")
    forecast_data = await make_nws_request(forecast_url)

    if not forecast_data:
        result = "Unable to fetch detailed forecast."
        logger.error(f"Failed to fetch forecast data from: {forecast_url}")
        print(f"[{datetime.now().strftime('%H:%M:%S')}] ❌ Failed to fetch detailed forecast")
        return result

    # Format the periods into a readable forecast
    periods = forecast_data["properties"]["periods"]
    forecasts = []
    for period in periods[:5]:  # Only show next 5 periods
        forecast = f"""
{period['name']}:
Temperature: {period['temperature']}°{period['temperatureUnit']}
Wind: {period['windSpeed']} {period['windDirection']}
Forecast: {period['detailedForecast']}
"""
        forecasts.append(forecast)

    result = "\n---\n".join(forecasts)
    logger.info(f"Successfully generated forecast with {len(forecasts)} periods")
    print(f"[{datetime.now().strftime('%H:%M:%S')}] ✅ Generated forecast with {len(forecasts)} periods")
    return result

@app.post("/api/forecast")
async def api_get_forecast(request: ForecastRequest):
    """Get weather forecast for coordinates"""
    try:
        result = await get_forecast(request.latitude, request.longitude)
        return {"success": True, "data": result}
    except Exception as e:
        return {"success": False, "error": str(e)}


async def start_uvicorn():
    print("🌤️  Starting Weather HTTP API Server")
    print("🔗 API docs at http://localhost:8082/docs")
    print("=" * 50, end="\n\n")
    config = uvicorn.Config(
        app,
        host="0.0.0.0",
        port=8082,
        log_level="info"
    )
    server = uvicorn.Server(config)
    await server.serve()

async def start_mcp():
    print("🌤️  Starting Weather MCP Server with SSE transport")
    print("🚀 Registered tools:")
    for tool in mcp._tool_manager.list_tools():
        print(f"🔧 Tool: {tool.name} - {tool.description}")
    print("🔗 Server will run on http://localhost:8000/sse")
    print("=" * 50, end="\n\n")
    await mcp.run_sse_async()

async def main():
    # Start Prometheus metrics server
    print("📊 Prometheus metrics at http://localhost:8090/")
    print("=" * 50, end="\n\n")
    start_http_server(
        addr="0.0.0.0",
        port=8090
    )
    
    await asyncio.gather(
        start_uvicorn(),
        start_mcp(),
    )

if __name__ == "__main__":
    asyncio.run(main())
    