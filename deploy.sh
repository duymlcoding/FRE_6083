#!/bin/bash

set -e  # Exit on error

echo "=============================================="
echo "   NYU FRE Notes - Multi-Course Deployment"
echo "=============================================="
echo ""

# Function to build a course if it exists and has proper structure
build_course() {
    local course_path=$1
    local course_name=$2

    if [ -d "$course_path" ] && [ -f "$course_path/_config.yml" ]; then
        echo "📚 Building $course_name..."
        jupyter-book build "$course_path"
        echo "✓ $course_name build complete"
        echo ""
        return 0
    else
        echo "⊘ Skipping $course_name (not ready)"
        echo ""
        return 1
    fi
}

# Build all courses
echo "Step 1: Building Jupyter Books"
echo "----------------------------------------------"

# FRE 6083 (Main course)
build_course "courses/FRE_6083" "FRE 6083 - Quantitative Methods"

# FRE 6083 Recitation
build_course "courses/FRE_6083_Recitation" "FRE 6083 - Recitation"

# FRE 6073
build_course "courses/FRE_6073" "FRE 6073"

# FRE 6103
build_course "courses/FRE_6103" "FRE 6103"

# FRE 6141
build_course "courses/FRE_6141" "FRE 6141"

# FRE 6731
build_course "courses/FRE_6731" "FRE 6731"

echo ""
echo "Step 2: Preparing Deployment Directory"
echo "----------------------------------------------"

# Create deployment directory
rm -rf _deploy
mkdir -p _deploy

# Copy landing page
if [ -f "index.html" ]; then
    echo "📄 Copying landing page..."
    cp index.html _deploy/
fi

# Copy course builds
echo "📦 Copying course builds..."

# Create courses directory in deployment
mkdir -p _deploy/courses

# Copy FRE 6083 (keep at root level for backward compatibility)
if [ -d "courses/FRE_6083/_build/html" ]; then
    cp -r courses/FRE_6083/_build/html _deploy/courses/FRE_6083
    echo "  ✓ FRE 6083"
fi

# Copy other courses
for course in FRE_6083_Recitation FRE_6073 FRE_6103 FRE_6141 FRE_6731; do
    if [ -d "courses/$course/_build/html" ]; then
        cp -r "courses/$course/_build/html" "_deploy/courses/$course"
        echo "  ✓ $course"
    fi
done

echo ""
echo "Step 3: Deploying to GitHub Pages"
echo "----------------------------------------------"

# Deploy using ghp-import
echo "🚀 Pushing to gh-pages branch..."
ghp-import -n -p -f _deploy

echo ""
echo "=============================================="
echo "   ✅ Deployment Complete!"
echo "=============================================="
echo ""
echo "🌐 Your site will be live at:"
echo "   Landing: https://duymlcoding.github.io/NYU_FRE_Notes/"
echo ""
echo "📚 Available courses:"

# List deployed courses
if [ -d "_deploy/courses/FRE_6083" ]; then
    echo "   • FRE 6083: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083/"
fi
if [ -d "_deploy/courses/FRE_6083_Recitation" ]; then
    echo "   • FRE 6083 Recitation: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083_Recitation/"
fi
if [ -d "_deploy/courses/FRE_6073" ]; then
    echo "   • FRE 6073: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6073/"
fi
if [ -d "_deploy/courses/FRE_6103" ]; then
    echo "   • FRE 6103: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6103/"
fi
if [ -d "_deploy/courses/FRE_6141" ]; then
    echo "   • FRE 6141: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6141/"
fi
if [ -d "_deploy/courses/FRE_6731" ]; then
    echo "   • FRE 6731: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6731/"
fi

echo ""
echo "Note: Allow 1-2 minutes for GitHub Pages to update"
echo "=============================================="
