# Ref: https://hub.docker.com/_/python/tags
FROM python:3.13.4-slim-bullseye

# Install uv (static binary)
RUN apt-get update && apt-get install -y curl ca-certificates && \
    curl -Ls https://astral.sh/uv/install.sh | bash

RUN mv /root/.local/bin/uv /usr/local/bin/uv && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Create a non-root user for development only
RUN useradd --home-dir /home/weather --create-home --groups sudo --shell /bin/bash weather

# Set working directory (owned by root at first)
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock ./

# Create a user-owned virtual environment path
# ENV VIRTUAL_ENV=/home/weather/.venv

# Install deps as root
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-dev --no-editable

# Copy the rest of the source code
COPY src src

# Set permissions for non-root user
RUN chown -R weather:weather /app /home/weather

# Switch to non-root user for running the app
USER weather

EXPOSE 8000 8090 8080

# Default command (adjust as needed)
CMD ["uv", "run", "/app/src/main.py"]