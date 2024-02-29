```bash
sudo apt install graphviz
terraform graph | dot -Tsvg > graph.svg
```

```bash
docker run --rm -i -t --volume ${PWD}:/workspace -w /workspace hashicorp/terraform:latest init
```