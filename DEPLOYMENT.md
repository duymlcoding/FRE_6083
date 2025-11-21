# Deployment Guide

Complete guide for deploying NYU FRE course notes to GitHub Pages using Jupyter Book.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Quick Deployment](#quick-deployment)
3. [Environment Setup](#environment-setup)
4. [Troubleshooting](#troubleshooting)
5. [Adding New Courses](#adding-new-courses)
6. [Manual Deployment Steps](#manual-deployment-steps)

---

## Prerequisites

### Required Software

- **Python 3.8+** (3.11 recommended)
- **Git** 2.x+
- **Bash shell**:
  - Mac/Linux: Built-in Terminal
  - Windows: Git Bash (NOT Command Prompt or WSL)

### Required Skills

- Basic command line usage
- Git basics (clone, commit, push)
- Text editor (vim, nano, VSCode, etc.)

---

## Quick Deployment

### Step-by-Step Instructions

```bash
# Step 1: Clone repository
git clone https://github.com/duymlcoding/NYU_FRE_Notes.git
cd NYU_FRE_Notes

# Step 2: Create virtual environment (REQUIRED)
python3 -m venv venv
source venv/bin/activate  # Windows Git Bash: source venv/Scripts/activate

# Step 3: Install dependencies
pip install -r courses/FRE_6083/requirements.txt

# Step 4: Deploy
./deploy.sh
```

### What Happens During Deployment

1. **Build Phase**: Converts Markdown → HTML for each course
   - FRE 6083: `courses/FRE_6083/_build/html/`
   - FRE 6073: `courses/FRE_6073/_build/html/`

2. **Prepare Phase**: Copies all HTML to `_deploy/` directory
   - Landing page (`index.html`)
   - All course HTML files

3. **Deploy Phase**: Pushes `_deploy/` contents to `gh-pages` branch using `ghp-import`

4. **GitHub Pages**: Automatically publishes from `gh-pages` branch (1-2 minutes)

### Verification

After deployment:

```bash
# Wait 1-2 minutes, then visit:
# https://duymlcoding.github.io/NYU_FRE_Notes/

# Check:
# - Landing page loads
# - Course links work
# - Math equations render in <div> blocks (not inline)
# - Search functionality works
```

---

## Environment Setup

### Python Virtual Environment (CRITICAL)

**Why required?**
- Modern systems use "externally managed" Python
- Installing globally will fail with pip errors
- Virtual environments isolate project dependencies

**Setup:**

```bash
# Create venv (one time)
python3 -m venv venv

# Activate venv (every session)
source venv/bin/activate  # Mac/Linux
source venv/Scripts/activate  # Windows Git Bash

# Verify activation (should show venv path)
which python

# Deactivate when done
deactivate
```

### Dependency Installation

**Key Dependencies:**
- `jupyter-book==1.0.4.post1` (PINNED - v2.x has bugs)
- `ghp-import>=2.1.0` (for deployment)
- `sphinx`, `sphinx-proof`, `sphinx-togglebutton`, etc.

**Install:**

```bash
# From requirements.txt (recommended)
pip install -r courses/FRE_6083/requirements.txt

# Or install manually
pip install 'jupyter-book==1.0.4.post1' 'ghp-import>=2.1.0'
```

**Verify Installation:**

```bash
jupyter-book --version
# Should show: v1.0.4.post1

ghp-import --version
# Should show: 2.1.0 or higher
```

---

## Troubleshooting

### Common Issues

#### 1. `externally managed environment` Error

**Symptom:**
```
error: externally-managed-environment
This environment is externally managed
```

**Solution:**
```bash
# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r courses/FRE_6083/requirements.txt
```

---

#### 2. `EISDIR: illegal operation on a directory` Error

**Symptom:**
```
⛔️ courses/FRE_6083 Error reading file: Error: EISDIR: illegal operation on a directory, read
```

**Cause:** jupyter-book v2.x has a bug

**Solution:**
```bash
# Downgrade to v1.0.4.post1
pip install 'jupyter-book==1.0.4.post1'

# Verify version
jupyter-book --version  # Should show v1.0.4.post1

# Rebuild
./deploy.sh
```

---

#### 3. Math Equations Not Rendering

**Symptom:** Display math shows as `$\(...\)$` instead of centered equations

**Cause:** Missing blank lines around `$$` blocks

**Fix:**
```markdown
❌ WRONG:
Text before equation:
$$
E[X] = \sum_{i} x_i p_i
$$
Text after equation

✅ CORRECT:
Text before equation:

$$
E[X] = \sum_{i} x_i p_i
$$

Text after equation
```

**Automated Fix:**
```bash
# Find problem files
grep -r -B 1 '^\$\$' courses/FRE_6083/chapters/ | grep -v '^--$' | grep -v '^\s*$'

# Add blank lines manually, then rebuild
./deploy.sh
```

---

#### 4. `403 Forbidden` on Push

**Symptom:**
```
error: RPC failed; HTTP 403 curl 22
fatal: the remote end hung up unexpectedly
```

**Solution:**
```bash
# The deployment script uses ghp-import which handles authentication
# If you see this error, make sure you're authenticated to GitHub:

# Option 1: Use Personal Access Token
git config --global credential.helper store
# Next git operation will prompt for username/token

# Option 2: Use SSH
git remote set-url origin git@github.com:duymlcoding/NYU_FRE_Notes.git

# Then retry deployment
./deploy.sh
```

---

#### 5. WSL Errors on Windows

**Symptom:**
```
<3>WSL (10) ERROR: CreateProcessParseCommon:711: Failed to translate...
```

**Solution:**
Use Git Bash instead of WSL or Command Prompt:
```bash
# Open Git Bash (search in Start Menu)
cd /c/Users/YourName/Desktop/NYU_FRE_Notes
./deploy.sh
```

---

#### 6. `ghp-import` Push Failed Silently

**Symptom:** Script completes but gh-pages not updated

**Solution:**
```bash
# Manual deployment
git checkout main
rm -rf _deploy
mkdir -p _deploy/courses

# Copy landing page
cp index.html _deploy/

# Build and copy FRE 6083
jupyter-book build courses/FRE_6083/
cp -r courses/FRE_6083/_build/html _deploy/courses/FRE_6083

# Build and copy FRE 6073 (if exists)
if [ -d "courses/FRE_6073/_config.yml" ]; then
    jupyter-book build courses/FRE_6073/
    cp -r courses/FRE_6073/_build/html _deploy/courses/FRE_6073
fi

# Deploy with explicit authentication
ghp-import -n -p -f _deploy

# Check if push succeeded
git fetch origin gh-pages
git log origin/gh-pages --oneline -5
```

---

## Adding New Courses

### Process Overview

1. Create course structure
2. Add Markdown content
3. Update deployment script
4. Build and deploy

### Detailed Steps

```bash
# 1. Create course directory
mkdir -p courses/FRE_XXXX/chapters
mkdir -p courses/FRE_XXXX/raw_materials

# 2. Copy template files from existing course
cp courses/FRE_6083/_config.yml courses/FRE_XXXX/
cp courses/FRE_6083/_toc.yml courses/FRE_XXXX/
cp courses/FRE_6083/index.md courses/FRE_XXXX/
cp courses/FRE_6083/intro.md courses/FRE_XXXX/
cp courses/FRE_6083/references.bib courses/FRE_XXXX/
cp courses/FRE_6083/requirements.txt courses/FRE_XXXX/

# 3. Edit _config.yml
vim courses/FRE_XXXX/_config.yml
# Update: title, author, path_to_book

# 4. Edit _toc.yml
vim courses/FRE_XXXX/_toc.yml
# Update: chapter file paths

# 5. Add chapter Markdown files
vim courses/FRE_XXXX/chapters/lecture01_topic.md
# ... add more chapters

# 6. Update deploy.sh
vim deploy.sh
# Add build_course line:
#   build_course "courses/FRE_XXXX" "FRE XXXX - Course Name"

# 7. Build and deploy
./deploy.sh
```

### _config.yml Template

```yaml
title: "FRE XXXX: Course Title"
author: "Professor Name"
copyright: "2025"

repository:
  url: https://github.com/duymlcoding/NYU_FRE_Notes
  path_to_book: courses/FRE_XXXX
  branch: main

html:
  use_issues_button: true
  use_repository_button: true
  use_edit_page_button: true
  baseurl: ""

execute:
  execute_notebooks: "off"

latex:
  latex_engine: pdflatex

sphinx:
  extra_extensions:
    - sphinx_proof
    - sphinx_togglebutton
    - sphinx_copybutton
  config:
    html_theme: sphinx_book_theme
    mathjax_path: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js
    mathjax3_config:
      tex:
        macros:
          "\\N": "\\mathbb{N}"
          "\\R": "\\mathbb{R}"
          "\\E": "\\mathbb{E}"
          "\\var": "\\text{var}"
          "\\cov": "\\text{cov}"

bibtex_bibfiles:
  - references.bib

exclude_patterns:
  - _build
  - Thumbs.db
  - .DS_Store
  - "**.ipynb_checkpoints"
```

### _toc.yml Template

```yaml
format: jb-book
root: index
title: Home

parts:
  - caption: Introduction
    chapters:
    - file: intro

  - caption: Lectures
    chapters:
    - file: chapters/lecture01_topic
      title: "Lecture 1: Topic Title"
    - file: chapters/lecture02_topic
      title: "Lecture 2: Topic Title"
    # ... add more chapters
```

---

## Manual Deployment Steps

If `./deploy.sh` fails, use these manual steps:

### 1. Activate Environment

```bash
source venv/bin/activate
```

### 2. Build Courses

```bash
# Build FRE 6083
jupyter-book build courses/FRE_6083/

# Build FRE 6073
jupyter-book build courses/FRE_6073/

# Check for errors
ls courses/FRE_6083/_build/html/  # Should show HTML files
```

### 3. Prepare Deployment Directory

```bash
# Clean and create
rm -rf _deploy
mkdir -p _deploy/courses

# Copy landing page
cp index.html _deploy/

# Copy course builds
cp -r courses/FRE_6083/_build/html _deploy/courses/FRE_6083
cp -r courses/FRE_6073/_build/html _deploy/courses/FRE_6073

# Verify
ls -la _deploy/courses/FRE_6083/  # Should show index.html, chapters/, etc.
```

### 4. Deploy to GitHub Pages

```bash
# Deploy using ghp-import
ghp-import -n -p -f _deploy

# Verify deployment
git fetch origin gh-pages
git log origin/gh-pages --oneline -5

# Check latest commit is about your changes
```

### 5. Wait and Verify

```bash
# Wait 1-2 minutes for GitHub Pages to build

# Visit site
# https://duymlcoding.github.io/NYU_FRE_Notes/

# Check deployment status
# https://github.com/duymlcoding/NYU_FRE_Notes/deployments
```

---

## Advanced Topics

### Clean Build

Remove cached files to force complete rebuild:

```bash
# Clean specific course
jupyter-book clean courses/FRE_6083/

# Clean all courses
find courses -name "_build" -type d -exec rm -rf {} +

# Clean deployment directory
rm -rf _deploy

# Rebuild from scratch
./deploy.sh
```

### Local Preview

Preview changes before deploying:

```bash
# Build course
jupyter-book build courses/FRE_6083/

# Start local server
cd courses/FRE_6083/_build/html
python -m http.server 8000

# Visit: http://localhost:8000
# Press Ctrl+C to stop server
```

### Deployment Without Push

Build and prepare without pushing to GitHub:

```bash
# Comment out ghp-import line in deploy.sh
vim deploy.sh
# Change: ghp-import -n -p -f _deploy
# To:     # ghp-import -n -p -f _deploy

# Run script
./deploy.sh

# Manual inspection
cd _deploy
ls -la

# Manual push when ready
ghp-import -n -p -f ../deploy
```

---

## AI Agent Instructions

### Critical Steps for AI Agents

1. **ALWAYS create virtual environment first**
2. **ALWAYS verify jupyter-book version is 1.0.4.post1**
3. **ALWAYS check for blank lines around `$$` blocks**
4. **NEVER skip environment setup**
5. **NEVER use jupyter-book v2.x**

### Deployment Checklist for AI Agents

```bash
# 1. Environment
[ ] Virtual environment created and activated
[ ] Dependencies installed from requirements.txt
[ ] jupyter-book --version shows v1.0.4.post1

# 2. Content
[ ] Markdown files have blank lines around $$ blocks
[ ] All _config.yml files valid YAML
[ ] All _toc.yml files reference existing chapter files

# 3. Build
[ ] jupyter-book build completes without errors
[ ] HTML files generated in _build/html/
[ ] Math renders in <div> blocks, not inline

# 4. Deploy
[ ] _deploy directory created successfully
[ ] All course HTML copied to _deploy/courses/
[ ] ghp-import pushes without errors
[ ] gh-pages branch updated on GitHub

# 5. Verify
[ ] Wait 1-2 minutes for GitHub Pages
[ ] Visit live site URL
[ ] Check all courses load
[ ] Verify math rendering
```

---

## Reference

### Important Files

| File | Purpose |
|------|---------|
| `deploy.sh` | Main deployment script |
| `courses/*/requirements.txt` | Python dependencies |
| `courses/*/_config.yml` | Jupyter Book configuration |
| `courses/*/_toc.yml` | Table of contents |
| `courses/*/chapters/*.md` | Course content (EDIT THESE) |
| `_deploy/` | Temporary build output (git ignored) |

### Important Commands

| Command | Purpose |
|---------|---------|
| `python3 -m venv venv` | Create virtual environment |
| `source venv/bin/activate` | Activate venv |
| `pip install -r requirements.txt` | Install dependencies |
| `jupyter-book build courses/FRE_6083/` | Build single course |
| `jupyter-book clean courses/FRE_6083/` | Clean build cache |
| `./deploy.sh` | Build and deploy all courses |
| `ghp-import -n -p -f _deploy` | Deploy to gh-pages |

### URLs

| Resource | URL |
|----------|-----|
| Live site | https://duymlcoding.github.io/NYU_FRE_Notes/ |
| Repository | https://github.com/duymlcoding/NYU_FRE_Notes |
| Deployments | https://github.com/duymlcoding/NYU_FRE_Notes/deployments |
| Jupyter Book docs | https://jupyterbook.org/ |
| Sphinx docs | https://www.sphinx-doc.org/ |

---

## Support

**Issues?** Check:
1. This troubleshooting section
2. [README.md](README.md) Quick Start
3. [Jupyter Book Documentation](https://jupyterbook.org/)
4. [Open GitHub Issue](https://github.com/duymlcoding/NYU_FRE_Notes/issues)

---

**Last Updated:** 2025-11-21
**Jupyter Book Version:** 1.0.4.post1
**Python Version:** 3.8+
