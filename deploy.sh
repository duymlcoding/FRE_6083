#!/bin/bash

# Build the book
echo "Building Jupyter Book..."
jupyter-book build mynotes/

# Deploy to GitHub Pages
echo "Deploying to GitHub Pages..."
ghp-import -n -p -f mynotes/_build/html

echo "Deployment complete! Site will be live at:"
echo "https://duymlcoding.github.io/FRE_6083/"
