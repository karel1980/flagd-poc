#!/bin/bash

echo "=== FLAGD MRE (Minimal Reproducible Example) ==="
echo ""
echo "This script will demonstrate the flagd setup with a Spring Boot application."
echo ""
read -p "Press Enter to start..."

echo ""
echo "Step 1: Starting services with docker compose..."
echo "This will start flagd and the application container."
echo ""
read -p "Press Enter to continue..."
docker compose up -d --build

echo ""
echo "Waiting for services to be ready..."
sleep 5

echo ""
echo "Step 2: Curling the 'hello' and 'hello-details' endpoints..."
echo ""
read -p "Press Enter to continue..."
echo "Calling /hello endpoint:"
curl -s http://localhost:8080/hello
echo ""
echo ""
echo "Calling /hello-details endpoint:"
curl -s http://localhost:8080/hello-details
echo ""

echo ""
echo "Step 3: Showing docker logs for the flagd container..."
echo ""
read -p "Press Enter to continue..."
docker compose logs flagd

echo ""
echo "Step 4: Changing flag configuration to 'off'..."
echo "Copying demo.flagd.example.off.json to demo.flagd.json"
echo ""
read -p "Press Enter to continue..."
cp flags/demo.flagd.example.off.json flags/demo.flagd.json
echo "Flag configuration updated."

echo ""
echo "Step 5: Showing flagd container logs again..."
echo "This will show an error from the configuration change."
echo ""
read -p "Press Enter to continue..."
docker compose logs flagd

echo ""
echo "Step 6: Curling both endpoints again..."
echo ""
read -p "Press Enter to continue..."
echo "Calling /hello endpoint:"
curl -s http://localhost:8080/hello
echo ""
echo ""
echo "Calling /hello-details endpoint:"
curl -s http://localhost:8080/hello-details
echo ""

echo ""
echo "Step 7: Stopping containers and reverting changes..."
echo "This will stop all services and restore the original flag configuration."
echo ""
read -p "Press Enter to continue..."
docker compose down
cp flags/demo.flagd.example.on.json flags/demo.flagd.json
echo "Containers stopped and demo.flagd.json reverted to original state."

echo ""
echo "=== Demo Complete ==="
echo ""
