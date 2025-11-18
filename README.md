# NYU FRE Course Notes

> Open-source course materials for NYU Tandon Financial Risk Engineering graduate program

[![GitHub Pages](https://img.shields.io/badge/View-Live%20Site-purple?style=for-the-badge&logo=github)](https://duymlcoding.github.io/NYU_FRE_Notes/)
[![NYU Tandon](https://img.shields.io/badge/NYU-Tandon%20FRE-57068c?style=for-the-badge)](https://engineering.nyu.edu/academics/programs/financial-engineering-ms)

---

## 📚 Available Courses

### ✅ Currently Available

| Course Code | Course Title | Status | View Notes |
|------------|--------------|---------|------------|
| **FRE 6083** | Quantitative Methods | ✓ Live | [View Course →](https://duymlcoding.github.io/NYU_FRE_Notes/courses/FRE_6083/) |

### ⏳ Coming Soon

| Course Code | Status |
|------------|---------|
| **FRE 6083 Recitation** | Materials pending |
| **FRE 6073** | Materials pending |
| **FRE 6103** | Materials pending |
| **FRE 6141** | Materials pending |
| **FRE 6731** | Materials pending |

---

## 🎯 About This Project

This repository contains professionally formatted course notes for NYU Tandon's Financial Risk Engineering graduate program. All notes are converted from raw lecture materials into interactive Jupyter Books with:

- ✨ Professional LaTeX math rendering
- 📖 Interactive admonitions and dropdowns
- 🎨 Clean, readable formatting
- 📱 Mobile-responsive design
- 🔍 Full-text search functionality
- 🌐 Deployed on GitHub Pages for easy access

---

## 🏗️ Repository Structure

```
NYU_FRE_Notes/
├── index.html                          # Landing page for all courses
├── courses/                            # All course materials
│   ├── FRE_6083/                      # FRE 6083 - Quantitative Methods
│   │   ├── _config.yml                # Jupyter Book configuration
│   │   ├── _toc.yml                   # Table of contents
│   │   ├── index.md                   # Course homepage
│   │   ├── intro.md                   # Course introduction
│   │   ├── chapters/                  # Lecture notes (13 chapters)
│   │   ├── raw_materials/             # Original .txt files
│   │   ├── references.bib             # Bibliography
│   │   └── requirements.txt           # Python dependencies
│   │
│   ├── FRE_6083_Recitation/          # FRE 6083 TA materials
│   │   └── raw_materials/            # Upload .txt files here
│   │
│   ├── FRE_6073/                     # Course materials
│   │   └── raw_materials/            # Upload .txt files here
│   │
│   ├── FRE_6103/                     # Course materials
│   │   └── raw_materials/            # Upload .txt files here
│   │
│   ├── FRE_6141/                     # Course materials
│   │   └── raw_materials/            # Upload .txt files here
│   │
│   └── FRE_6731/                     # Course materials
│       └── raw_materials/            # Upload .txt files here
│
├── deploy.sh                          # Multi-course deployment script
├── .gitignore                         # Git ignore rules
├── README.md                          # This file
├── DEPLOYMENT_INSTRUCTIONS.md         # Detailed deployment guide
└── MULTI_COURSE_GUIDE.md             # Guide for adding new courses
```

---

## 🚀 Quick Start

### Viewing the Notes

Visit the live site: **[https://duymlcoding.github.io/NYU_FRE_Notes/](https://duymlcoding.github.io/NYU_FRE_Notes/)**

### Local Development

1. **Clone the repository:**
```bash
git clone https://github.com/duymlcoding/NYU_FRE_Notes.git
cd NYU_FRE_Notes
```

2. **Install dependencies:**
```bash
pip install -r courses/FRE_6083/requirements.txt
```

3. **Build a course locally:**
```bash
# Build FRE 6083
jupyter-book build courses/FRE_6083/

# View locally
cd courses/FRE_6083/_build/html
python -m http.server 8000
# Open browser to http://localhost:8000
```

4. **Deploy all courses:**
```bash
chmod +x deploy.sh
./deploy.sh
```

---

## 📝 Adding New Course Materials

### For Course Contributors

Want to add materials for a new course? Follow these steps:

1. **Upload your .txt lecture files** to the appropriate `raw_materials/` directory:
   - `courses/FRE_XXXX/raw_materials/`

2. **Tag Claude** (or create an issue) to convert the materials:
   - "Claude, please convert FRE XXXX materials to Jupyter Book format"

3. **Review and merge** the converted materials

4. **Deploy** using `./deploy.sh`

See **[MULTI_COURSE_GUIDE.md](MULTI_COURSE_GUIDE.md)** for detailed instructions.

---

## 🎓 FRE 6083: Quantitative Methods

### Course Overview

Comprehensive coverage of probability theory and stochastic processes for quantitative finance, taught by Professor Agnès Tourin.

### Topics Covered

1. **Sequences and Sums of Random Variables** - Binomial models, CLT, LLN
2. **Convergence and Limit Theorems** - Modes of convergence, characteristic functions
3. **Markov Chains** - Transition matrices, stationary distributions
4. **Poisson Processes** - Counting processes, exponential distributions
5. **Binomial Asset Pricing Model** - Risk-neutral pricing, arbitrage
6. **Stochastic Processes** - Filtrations, martingales, stopping times
7. **Brownian Motion (Part 1)** - Construction, properties, scaling
8. **Brownian Motion (Part 2)** - Quadratic variation, first passage times
9. **Stochastic Calculus** - Itô integral, Itô's lemma
10. **Black-Scholes Model** - Derivation, risk-neutral pricing
11. **Black-Scholes PDE & Finite Difference Methods**
12. **Portfolio Optimization (Discrete Time)** - Mean-variance optimization
13. **American Options & Greeks** - Early exercise, hedging parameters

### Features

- 📐 Full LaTeX mathematical notation
- 💡 Physical interpretations after key formulas
- 🔍 Worked examples with dropdown solutions
- 📊 Clear theorem and proof formatting
- 🎯 Important concept highlighting

---

## 🛠️ Technical Details

### Built With

- [Jupyter Book](https://jupyterbook.org/) (v1.0.4.post1) - Static site generator
- [Sphinx](https://www.sphinx-doc.org/) (v7.4.7) - Documentation builder
- [MathJax 3](https://www.mathjax.org/) - LaTeX math rendering
- [MyST Markdown](https://myst-parser.readthedocs.io/) - Enhanced markdown parser
- [GitHub Pages](https://pages.github.com/) - Hosting

### Jupyter Book Extensions

- `sphinx-proof` - Theorems, proofs, definitions
- `sphinx-togglebutton` - Collapsible content
- `sphinx-copybutton` - Copy code blocks

### Python Dependencies

```
jupyter-book>=1.0.0,<2.0.0
sphinx-proof>=0.3.0
sphinx-togglebutton>=0.3.0
sphinx-copybutton>=0.5.0
ghp-import>=2.1.0
matplotlib>=3.5.0
numpy>=1.21.0
```

---

## 📖 Documentation

- **[DEPLOYMENT_INSTRUCTIONS.md](DEPLOYMENT_INSTRUCTIONS.md)** - Step-by-step deployment guide
- **[MULTI_COURSE_GUIDE.md](MULTI_COURSE_GUIDE.md)** - Adding multiple courses
- **Course READMEs** - Each `raw_materials/` folder has upload instructions

---

## 🤝 Contributing

This is an open-source educational project maintained by NYU FRE students. Contributions are welcome!

### How to Contribute

1. **Add course materials** - Upload .txt files to appropriate directories
2. **Fix typos or errors** - Submit pull requests with corrections
3. **Improve formatting** - Enhance existing notes
4. **Share feedback** - Open issues with suggestions

### Contribution Guidelines

- Maintain consistent formatting across all courses
- Use proper LaTeX syntax for mathematical expressions
- Include "Physical Meaning" sections after key formulas
- Add worked examples where appropriate
- Follow existing Jupyter Book admonitions style

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Course Materials

Individual course materials may have additional copyright restrictions. Please respect the intellectual property of course instructors.

---

## 🔗 Links

- **Live Site:** [https://duymlcoding.github.io/NYU_FRE_Notes/](https://duymlcoding.github.io/NYU_FRE_Notes/)
- **Repository:** [https://github.com/duymlcoding/NYU_FRE_Notes](https://github.com/duymlcoding/NYU_FRE_Notes)
- **NYU FRE Program:** [https://engineering.nyu.edu/academics/programs/financial-engineering-ms](https://engineering.nyu.edu/academics/programs/financial-engineering-ms)
- **Jupyter Book Docs:** [https://jupyterbook.org/](https://jupyterbook.org/)

---

## 📧 Contact

For questions or suggestions:

- Open an issue in this repository
- Contact NYU FRE program administration
- Reach out to course contributors

---

## 🙏 Acknowledgments

- **Professor Agnès Tourin** - FRE 6083 course content
- **NYU Tandon School of Engineering** - Financial Risk Engineering program
- **All course TAs and instructors** - Original lecture materials
- **Student contributors** - Converting and maintaining these notes

---

<div align="center">

**Made with 💜 by NYU FRE Students**

*Open-source educational materials for the FRE community*

[View Live Site](https://duymlcoding.github.io/NYU_FRE_Notes/) • [Report Issue](https://github.com/duymlcoding/NYU_FRE_Notes/issues) • [Contribute](https://github.com/duymlcoding/NYU_FRE_Notes/pulls)

</div>
