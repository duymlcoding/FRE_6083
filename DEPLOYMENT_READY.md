# DEPLOYMENT READY - Manual Steps Required

## Current Status

✅ **Built Successfully:**
- Landing page: `_deploy/index.html`
- FRE 6083: `_deploy/courses/FRE_6083/` (13 lectures)
- FRE 6073: `_deploy/courses/FRE_6073/` (Chapter 1 complete)

## Issue

The gh-pages branch currently has the old structure where FRE_6083 was at the root. We need to update it to the new multi-course structure.

## Manual Deployment Steps

### Option 1: Using GitHub Web Interface (Easiest)

1. Go to your repository settings → Pages
2. Change source to: **Deploy from a branch** → **claude/gh-pages-deploy-019sVU3Dxqxz5BWv8i4QcXkm**
3. Wait 1-2 minutes for deployment
4. Test the URLs:
   - Landing: https://duymlcoding.github.io/NYU_FRE_Notes/
   - FRE 6083: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083/
   - FRE 6073: https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6073/

### Option 2: Manually Update gh-pages Branch

```bash
# In your local repository

# 1. Checkout gh-pages branch
git checkout gh-pages

# 2. Remove old content
git rm -rf .

# 3. Copy new deployment
cp -r _deploy/* .

# 4. Commit and push
git add .
git commit -m "Update to multi-course structure"
git push origin gh-pages

# 5. Return to main branch
git checkout main
```

### Option 3: Using deploy.sh Script

The deployment content is ready in `_deploy/` directory. You can manually push it:

```bash
cd _deploy
git init
git add .
git commit -m "Deploy multi-course site"
git branch -M gh-pages
git remote add origin https://github.com/duymlcoding/NYU_FRE_Notes.git
git push -f origin gh-pages
cd ..
```

## Expected URLs After Deployment

- **Landing Page:** https://duymlcoding.github.io/NYU_FRE_Notes/
- **FRE 6083:** https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083/
- **FRE 6073:** https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6073/

## Verification

After deployment, check:
- ✓ Landing page shows both courses
- ✓ Clicking "FRE 6083" takes you to the full course
- ✓ Clicking "FRE 6073" takes you to Chapter 1

## Troubleshooting

If links don't work:
1. Check GitHub Pages settings points to correct branch
2. Wait 1-2 minutes for GitHub Pages to rebuild
3. Clear browser cache (Ctrl+Shift+R)
4. Check URL paths match expected structure above

---

**Ready to deploy!** The `_deploy/` directory contains everything needed.
