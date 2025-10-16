#!/bin/bash
# Complete build and test in Docker

DOCKER_IMAGE="mcr.microsoft.com/dotnet/sdk:10.0"

echo "Building and testing npgsql in Docker..."

docker run --rm \
  -v "$(pwd):/app" \
  -w /app \
  "$DOCKER_IMAGE" \
  bash -c "
    echo '=== .NET SDK Info ==='
    dotnet --info
    
    echo ''
    echo '=== Clean ==='
    dotnet clean
    
    echo ''
    echo '=== Restore ==='
    dotnet restore
    
    echo ''
    echo '=== Build ==='
    dotnet build -c Release
    
    echo ''
    echo '=== Test (if you want) ==='
    # dotnet test -c Release
  "
