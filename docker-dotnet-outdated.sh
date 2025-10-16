#!/bin/bash
# Script to run dotnet outdated in Docker container without installing .NET 10 on host

DOCKER_IMAGE="mcr.microsoft.com/dotnet/sdk:10.0"
PROJECT_DIR="$(pwd)"

echo "Running dotnet outdated in Docker container..."
echo "Image: $DOCKER_IMAGE"
echo "Project: $PROJECT_DIR"
echo ""

docker run --rm \
  -v "$PROJECT_DIR:/app" \
  -w /app \
  "$DOCKER_IMAGE" \
  bash -c "
    echo 'Installing dotnet-outdated-tool...'
    dotnet tool install --global dotnet-outdated-tool --version 4.* 2>/dev/null || true
    export PATH=\"\$PATH:/root/.dotnet/tools\"
    
    echo ''
    echo '=== Running dotnet outdated ==='
    dotnet outdated --pre-release Always
    
    echo ''
    echo '=== Running dotnet outdated with upgrade option ==='
    dotnet outdated --pre-release Always --upgrade
  "

echo ""
echo "Done! Check the output above."
