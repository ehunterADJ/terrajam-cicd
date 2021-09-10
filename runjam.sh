#!/bin/bash
echo "Running TerraForm deploy"
cd terrajam
terraform apply -auto-approve
echo "Pushing up build"
cd ..
npm run build
cd build
aws s3 sync . s3://jam-my-example-an3
cd ..
