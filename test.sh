#!/bin/bash

set -e

echo "Starting services..."
docker compose up -d --build
sleep 5

echo "Test 1: First call should return uppercase"
RESULT=$(curl -s http://localhost:8080/hello)
if [ "$RESULT" = "HELLO WORLD!" ]; then
    echo "✓ PASS: Got uppercase"
else
    echo "✗ FAIL: Expected 'HELLO WORLD!' but got '$RESULT'"
    docker compose down
    exit 1
fi

echo "Changing flag to off..."
cp flags/demo.flagd.example.off.json flags/demo.flagd.json
sleep 2

echo "Test 2: Second call should return lowercase"
RESULT=$(curl -s http://localhost:8080/hello)
if [ "$RESULT" = "Hello World!" ]; then
    echo "✓ PASS: Got lowercase"
else
    echo "✗ FAIL: Expected 'Hello World!' but got '$RESULT'"
    docker compose down
    cp flags/demo.flagd.example.on.json flags/demo.flagd.json
    exit 1
fi

echo "Cleaning up..."
docker compose down
cp flags/demo.flagd.example.on.json flags/demo.flagd.json

echo ""
echo "All tests passed!"
