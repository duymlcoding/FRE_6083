# NYU FRE Course Notes

> Open-source course materials for NYU Tandon Financial Risk Engineering graduate program

[![GitHub Pages](https://img.shields.io/badge/View-Live%20Site-purple?style=for-the-badge&logo=github)](https://duymlcoding.github.io/NYU_FRE_Notes/)
[![NYU Tandon](https://img.shields.io/badge/NYU-Tandon%20FRE-57068c?style=for-the-badge)](https://engineering.nyu.edu/academics/programs/financial-engineering-ms)

---

## 📚 Available Courses

| Course Code | Course Title | Status | View Notes |
|------------|--------------|---------|------------|
| **FRE 6083** | Quantitative Methods | ✓ Live | [View Course →](https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083/) |
| **FRE 6073** | Introduction to Derivatives | ✓ Live | [View Course →](https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6073/) |
| **FRE 6103** | Valuation Methods for Financial Engineering | ✓ Live | [View Course →](https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6103/) |

---

## 🚀 Quick Start

### For AI Agents & Developers

**Prerequisites:**
- Python 3.8+
- Git
- Bash shell (Git Bash on Windows, Terminal on Mac/Linux)

**Complete Setup & Deployment:**

```bash
# 1. Clone repository
git clone https://github.com/duymlcoding/NYU_FRE_Notes.git
cd NYU_FRE_Notes

# 2. Set up Python environment (REQUIRED)
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# 3. Install dependencies (IMPORTANT: Use pinned version)
pip install -r courses/FRE_6083/requirements.txt

# 4. Build and deploy all courses
./deploy.sh
```

**That's it!** The site will be live at https://duymlcoding.github.io/NYU_FRE_Notes/ in 1-2 minutes.

---

## 📁 Repository Structure

```
NYU_FRE_Notes/
├── index.html                    # Landing page
├── deploy.sh                     # Deployment script (BUILD + DEPLOY)
├── courses/                      # All course materials
│   ├── FRE_6083/                # Quantitative Methods
│   │   ├── _config.yml          # Jupyter Book config
│   │   ├── _toc.yml             # Table of contents
│   │   ├── chapters/            # Lecture Markdown files (EDIT THESE)
│   │   └── requirements.txt     # Python dependencies
│   ├── FRE_6073/                # Introduction to Derivatives
│   │   └── ...
│   └── FRE_6103/                # Valuation Methods
│       └── ...
└── DEPLOYMENT.md                 # Detailed deployment guide
```

---

## 🛠️ Common Tasks

### Edit Course Content

```bash
# 1. Edit Markdown files
vim courses/FRE_6083/chapters/lecture01_sequences-and-sums.md

# 2. Rebuild and redeploy
source venv/bin/activate  # If not already activated
./deploy.sh
```

### Add New Course

See [DEPLOYMENT.md](DEPLOYMENT.md#adding-new-courses) for detailed instructions.

### Fix Formatting Issues

**IMPORTANT**: Display math blocks (`$$`) MUST have blank lines before and after:

```markdown
❌ WRONG:
Some text:
$$
math here
$$
```

```markdown
✅ CORRECT:
Some text:

$$
math here
$$

Next paragraph
```

---

## 🔧 Technical Stack

- **Jupyter Book** v1.0.4.post1 (pinned - v2.x has bugs)
- **Sphinx** v7.4.7
- **MathJax 3** for LaTeX rendering
- **GitHub Pages** for hosting
- **Python 3.8+**

---

## 📖 Documentation

- **[DEPLOYMENT.md](DEPLOYMENT.md)** - Complete deployment guide for AI agents & developers
- **[MULTI_COURSE_GUIDE.md](MULTI_COURSE_GUIDE.md)** - How to add new courses

---

## ⚠️ Important Notes for AI Agents

### Critical Requirements

1. **Always use virtual environment** - Python externally managed environments will fail
2. **Use jupyter-book v1.0.4.post1** - Version 2.x has EISDIR bugs
3. **Blank lines around `$$`** - Required for proper math rendering
4. **Test on Mac/Linux** - Windows requires Git Bash or WSL

### Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| `externally managed environment` | Create venv: `python3 -m venv venv && source venv/bin/activate` |
| `EISDIR: illegal operation` | Downgrade: `pip install 'jupyter-book==1.0.4.post1'` |
| Math not rendering | Add blank lines before/after `$$` blocks |
| `403 error` on push | Use `ghp-import` (included in requirements.txt) |
| WSL path errors on Windows | Use Git Bash instead |

### Deployment Verification

After running `./deploy.sh`, verify:
1. Script completes without errors
2. Visit https://duymlcoding.github.io/NYU_FRE_Notes/ (wait 1-2 min)
3. Check display math renders correctly in `<div>` blocks, not inline

---

## 🤝 Contributing

Contributions welcome! Please:
- Maintain consistent formatting
- Use proper LaTeX syntax with blank lines around `$$`
- Test locally before deploying
- Follow existing admonitions style

---

## 📜 License

MIT License - See [LICENSE](LICENSE) for details.

Course materials may have additional copyright restrictions. Respect instructor intellectual property.

---

## 🙏 Acknowledgments

- **Professor Agnès Tourin** - FRE 6083
- **John C. Hull** - FRE 6073 materials
- **David C. Shimko** - FRE 6103 materials
- **NYU Tandon School of Engineering**
- **Student contributors**

---

<div align="center">

**Made with 💜 by NYU FRE Students**

*Open-source educational materials for the FRE community*

[View Live Site](https://duymlcoding.github.io/NYU_FRE_Notes/) • [Deployment Guide](DEPLOYMENT.md) • [Report Issue](https://github.com/duymlcoding/NYU_FRE_Notes/issues)

</div>
