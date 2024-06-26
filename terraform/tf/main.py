
import hcl2
import networkx as nx
import os
import json
import re

def parse_terraform_files(directory):
    resources = {}
    for filename in os.listdir(directory):
        if filename.endswith(".tf"):
            with open(os.path.join(directory, filename), 'r') as file:
                data = hcl2.load(file)
                if 'resource' in data:
                    for instances in data['resource']:
                        for instance_type, instances in instances.items():
                            for resource_name, resource_props in instances.items():
                                resources[f"{ instance_type }.{ resource_name }"] = resource_props
    return resources

def extract_dependencies(resources):
    dependencies = {}
    for resource_name, resource_props in resources.items():
        if 'depends_on' in resource_props:
            dependencies[resource_name] = resource_props['depends_on']
        else:
            dependencies[resource_name] = []

        # Also add implicit dependencies from references within properties
        for prop_key, prop_value in resource_props.items():
            if isinstance(prop_value, str) and prop_value.startswith('${'):
                referenced_resources = extract_referenced_resources(prop_value)
                dependencies[resource_name].extend(referenced_resources)
    return dependencies

def extract_referenced_resources(expression):
    # This function extracts referenced resources from Terraform expressions
    pattern = r"\${([^}]+)}"
    matches = re.findall(pattern, expression)
    return matches

def build_dependency_graph(dependencies):
    graph = nx.DiGraph()
    for resource, deps in dependencies.items():
        for dep in deps:
            graph.add_edge(dep, resource)
    return graph

def main(directory):
    resources = parse_terraform_files(directory)
    print(json.dumps(resources, indent=2))
    dependencies = extract_dependencies(resources)
    print(json.dumps(dependencies, indent=2))
    graph = build_dependency_graph(dependencies)

    # Print out the dependency graph
    print("Resource Dependency Graph:")
    for line in nx.generate_edgelist(graph, data=False):
        print(line)

    # You can also visualize the graph using networkx's drawing utilities
    try:
        import matplotlib.pyplot as plt
        nx.draw(graph, with_labels=True, node_size=2000, node_color="skyblue", pos=nx.spring_layout(graph))
        plt.show()
    except ImportError:
        print("Matplotlib not installed, skipping graph visualization.")

if __name__ == "__main__":
    directory = ".."
    main(directory)
    # parse_terraform_files(directory=directory)
