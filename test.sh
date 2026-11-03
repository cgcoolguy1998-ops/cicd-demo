#!/bin/bash

set -e

echo "Running application tests..."

test -s index.html

grep -q "My CI/CD Pipeline is Working!" index.html

echo "All tests passed successfully!"