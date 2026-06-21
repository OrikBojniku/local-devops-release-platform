#!/bin/bash

echo "Duke gjeneruar SBOM per API Service..."
syft ./api --output spdx-json > api/sbom.json
echo "SBOM per API u gjenerua: api/sbom.json"

echo "Duke gjeneruar SBOM per Worker Service..."
syft ./worker --output spdx-json > worker/sbom.json
echo "SBOM per Worker u gjenerua: worker/sbom.json"

echo "Done!"
