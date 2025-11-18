# Multi-Course GitHub Pages Setup Guide

## Overview

This guide explains how to host multiple FRE courses (FRE 6083, FRE 6090, etc.) on the same GitHub Pages site with a professional landing page.

---

## Architecture Options

### Option A: Single Repository, Multiple Jupyter Books (RECOMMENDED)

**Structure:**
```
FRE_Courses/
├── index.html                      # Landing page listing all courses
├── courses/
│   ├── FRE_6083/                  # First course
│   │   ├── _config.yml
│   │   ├── _toc.yml
│   │   ├── index.md
│   │   └── chapters/
│   ├── FRE_6090/                  # Second course
│   │   ├── _config.yml
│   │   ├── _toc.yml
│   │   ├── index.md
│   │   └── chapters/
│   └── FRE_XXXX/                  # Additional courses...
├── deploy.sh                       # Unified deployment script
└── README.md
```

**Advantages:**
- ✅ Single repository to manage
- ✅ One GitHub Pages deployment
- ✅ Unified URL structure (e.g., yourusername.github.io/FRE_Courses/FRE_6083/)
- ✅ Easy cross-course navigation
- ✅ Shared resources (CSS, logos, common pages)

**Disadvantages:**
- ⚠️ Larger repository size
- ⚠️ Longer build times if many courses

**Best for:** Managing all your FRE courses in one place with unified branding

---

### Option B: Separate Repositories (Alternative)

**Structure:**
```
FRE_6083/           # Repository 1
FRE_6090/           # Repository 2
FRE_Courses_Hub/    # Landing page repository
```

**Advantages:**
- ✅ Independent course repositories
- ✅ Faster individual builds
- ✅ Separate access control per course

**Disadvantages:**
- ⚠️ Multiple repositories to manage
- ⚠️ Requires separate deployments
- ⚠️ More complex cross-linking

**Best for:** Courses with different collaborators or update schedules

---

## RECOMMENDED: Option A Implementation Guide

### Step 1: Create New Repository Structure

Since you already have `FRE_6083` working, you have two approaches:

#### Approach 1a: Restructure Current Repository (Cleanest)

1. **Rename current repository:**
   - Go to Settings → rename `FRE_6083` to `FRE_Courses`
   - Update GitHub Pages to use new URL

2. **Restructure files locally:**
```bash
# Create new structure
mkdir -p courses/FRE_6083
mkdir -p courses/FRE_6090

# Move FRE 6083 content
mv mynotes/* courses/FRE_6083/
mv archive courses/FRE_6083/

# Update paths in _config.yml
sed -i 's|path_to_book: mynotes|path_to_book: courses/FRE_6083|' courses/FRE_6083/_config.yml
```

#### Approach 1b: Keep Current Repository, Add New Courses (Simpler)

Keep `FRE_6083` as-is and add new courses alongside:

```bash
# Keep mynotes/ for FRE 6083
# Add new courses
mkdir -p courses/FRE_6090
```

This guide assumes **Approach 1b** (simpler, less disruptive).

---

### Step 2: Add FRE 6090 Course

When you're ready to add a new course:

1. **Upload .txt files** to the repository:
```bash
# Example: Upload week1_6090.txt, week2_6090.txt, etc. to content/FRE_6090/
mkdir -p content/FRE_6090
# Upload your .txt files here
```

2. **Create course structure:**
```bash
mkdir -p courses/FRE_6090/chapters
```

3. **I will help you convert the .txt files** using the same process we used for FRE 6083:
   - Convert all .txt files to Jupyter Book Markdown
   - Create _config.yml, _toc.yml, index.md, intro.md
   - Set up proper course metadata

4. **Example _config.yml for FRE 6090:**
```yaml
title: "FRE 6090: Advanced Derivatives"
author: "Professor Name"
copyright: "2025"

repository:
  url: https://github.com/duymlcoding/FRE_6083
  path_to_book: courses/FRE_6090
  branch: main

html:
  use_issues_button: true
  use_repository_button: true
  use_edit_page_button: true
  baseurl: "FRE_6090"

sphinx:
  extra_extensions:
    - sphinx_proof
    - sphinx_togglebutton
    - sphinx_copybutton
  config:
    mathjax_path: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js
```

---

### Step 3: Create Landing Page

Create a professional landing page that lists all courses:

**index.html** (place in repository root):

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NYU FRE Course Notes</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 50px;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            color: #667eea;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            color: #666;
            font-size: 1.2em;
            margin-bottom: 40px;
        }

        .courses {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 40px;
        }

        .course-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: white;
            display: block;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .course-card h2 {
            font-size: 1.8em;
            margin-bottom: 10px;
        }

        .course-card p {
            font-size: 1em;
            opacity: 0.95;
        }

        .course-code {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            margin-bottom: 15px;
            font-weight: bold;
        }

        footer {
            margin-top: 50px;
            text-align: center;
            color: #666;
            font-size: 0.9em;
        }

        .github-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .github-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>NYU FRE Course Notes</h1>
        <p class="subtitle">Open-source course materials for Financial Risk Engineering</p>

        <div class="courses">
            <a href="mynotes/" class="course-card">
                <span class="course-code">FRE 6083</span>
                <h2>Quantitative Methods</h2>
                <p>Probability foundations, stochastic processes, and quantitative finance applications</p>
            </a>

            <a href="courses/FRE_6090/" class="course-card">
                <span class="course-code">FRE 6090</span>
                <h2>Advanced Derivatives</h2>
                <p>Options pricing, exotic derivatives, and advanced hedging strategies</p>
            </a>

            <!-- Add more courses here as needed -->
            <!--
            <a href="courses/FRE_XXXX/" class="course-card">
                <span class="course-code">FRE XXXX</span>
                <h2>Course Title</h2>
                <p>Course description</p>
            </a>
            -->
        </div>

        <footer>
            <p><strong>NYU Tandon School of Engineering</strong></p>
            <p>Financial Risk Engineering Program</p>
            <a href="https://github.com/duymlcoding/FRE_6083" class="github-link">View on GitHub →</a>
        </footer>
    </div>
</body>
</html>
```

---

### Step 4: Update Deployment Script

**deploy.sh** - Builds all courses and deploys:

```bash
#!/bin/bash

set -e  # Exit on error

echo "========================================="
echo "Building All Jupyter Books"
echo "========================================="

# Build FRE 6083 (current structure)
echo ""
echo "📚 Building FRE 6083..."
jupyter-book build mynotes/

# Build FRE 6090 (when ready)
if [ -d "courses/FRE_6090" ]; then
    echo ""
    echo "📚 Building FRE 6090..."
    jupyter-book build courses/FRE_6090/
fi

# Add more courses here as needed
# if [ -d "courses/FRE_XXXX" ]; then
#     echo ""
#     echo "📚 Building FRE XXXX..."
#     jupyter-book build courses/FRE_XXXX/
# fi

echo ""
echo "========================================="
echo "Preparing Deployment Directory"
echo "========================================="

# Create deployment directory
rm -rf _deploy
mkdir -p _deploy

# Copy landing page
cp index.html _deploy/

# Copy FRE 6083 build
cp -r mynotes/_build/html _deploy/mynotes

# Copy FRE 6090 build (when ready)
if [ -d "courses/FRE_6090/_build/html" ]; then
    mkdir -p _deploy/courses
    cp -r courses/FRE_6090/_build/html _deploy/courses/FRE_6090
fi

# Add more course builds here
# if [ -d "courses/FRE_XXXX/_build/html" ]; then
#     mkdir -p _deploy/courses
#     cp -r courses/FRE_XXXX/_build/html _deploy/courses/FRE_XXXX
# fi

echo ""
echo "========================================="
echo "Deploying to GitHub Pages"
echo "========================================="

# Deploy to gh-pages
ghp-import -n -p -f _deploy

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🌐 Your site will be live at:"
echo "   Main: https://duymlcoding.github.io/FRE_6083/"
echo "   FRE 6083: https://duymlcoding.github.io/FRE_6083/mynotes/"
echo "   FRE 6090: https://duymlcoding.github.io/FRE_6083/courses/FRE_6090/"
```

---

### Step 5: Update .gitignore

```bash
# Jupyter Book build files
mynotes/_build/
courses/*/._build/
_build/
_deploy/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/

# OS
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# IDE
.vscode/
.idea/
*.sublime-project
*.sublime-workspace

# Jupyter
.ipynb_checkpoints
*.ipynb_checkpoints

# Temporary files
*.tmp
*.bak
*.log
```

---

## Workflow for Adding New Course

When you want to add a new course (e.g., FRE 6090):

### Step-by-Step Process:

1. **Upload .txt files to GitHub:**
   - Create directory: `content/FRE_6090/`
   - Upload all week/lecture .txt files

2. **Tag me in an issue or commit:**
   - "Claude, please convert FRE 6090 .txt files to Jupyter Book format"
   - I'll use the same conversion process as FRE 6083

3. **I will:**
   - Create `courses/FRE_6090/` structure
   - Convert all .txt files to Markdown with Jupyter Book admonitions
   - Set up _config.yml, _toc.yml, index.md, intro.md
   - Update deploy.sh to include new course
   - Update landing page index.html

4. **You merge and deploy:**
   - Review changes
   - Merge to main
   - Run `./deploy.sh`

---

## Quick Reference Commands

```bash
# Build single course
jupyter-book build mynotes/                  # FRE 6083
jupyter-book build courses/FRE_6090/         # FRE 6090

# Build and deploy all courses
./deploy.sh

# Clean all builds
jupyter-book clean mynotes/
jupyter-book clean courses/FRE_6090/

# Preview locally
cd mynotes/_build/html && python -m http.server 8000
# Visit: http://localhost:8000
```

---

## URL Structure

After deployment, your courses will be accessible at:

- **Landing Page:** https://duymlcoding.github.io/FRE_6083/
- **FRE 6083:** https://duymlcoding.github.io/FRE_6083/mynotes/
- **FRE 6090:** https://duymlcoding.github.io/FRE_6083/courses/FRE_6090/
- **FRE XXXX:** https://duymlcoding.github.io/FRE_6083/courses/FRE_XXXX/

---

## Summary

**For your next course (FRE 6090):**

1. Upload .txt files to `content/FRE_6090/` directory
2. Tag me to convert them to Jupyter Book format
3. I'll set up the complete course structure
4. You merge and run `./deploy.sh`
5. New course is live!

**This approach gives you:**
- ✅ One repository for all FRE courses
- ✅ Professional landing page with course catalog
- ✅ Consistent formatting across all courses
- ✅ Simple deployment workflow
- ✅ Easy maintenance and updates

---

**Questions?** Feel free to ask when you're ready to add the next course!
