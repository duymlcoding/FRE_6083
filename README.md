# FRE 6083: Quantitative Methods - Course Notes

Open-source course notes for FRE 6083: Quantitative Methods, built with Jupyter Book.

Taught by Professor Agnès Tourin.

## 🌐 View Online

Visit the course notes at: **[https://duymlcoding.github.io/FRE_6083/](https://duymlcoding.github.io/FRE_6083/)**

## 📚 Course Topics

This course covers:

### Part I: Probability Foundations
- Sequences and sums of random variables
- Convergence concepts and limit theorems
- Markov chains and applications

### Part II: Stochastic Processes
- The Poisson process
- Binomial asset pricing model
- Introduction to stochastic processes
- Brownian motion

### Part III: Advanced Topics
- Stochastic calculus and Ito's formula
- Black-Scholes model and PDE
- Finite difference methods
- Portfolio optimization
- American options and Greeks

## 🛠️ Local Development

### Prerequisites
- Python 3.8+
- pip

### Setup

1. Clone the repository:
```bash
git clone https://github.com/duymlcoding/FRE_6083.git
cd FRE_6083
```

2. Install dependencies:
```bash
pip install -r mynotes/requirements.txt
```

3. Build the book:
```bash
jupyter-book build mynotes/
```

4. View locally:
Open `mynotes/_build/html/index.html` in your browser

Or use Python's built-in server:
```bash
cd mynotes/_build/html
python -m http.server 8000
```
Then navigate to `http://localhost:8000`

### Deploy to GitHub Pages
```bash
chmod +x deploy.sh
./deploy.sh
```

## 📂 Repository Structure

```
FRE_6083/
├── mynotes/                    # Jupyter Book source
│   ├── _config.yml            # Book configuration
│   ├── _toc.yml              # Table of contents
│   ├── index.md              # Homepage
│   ├── intro.md              # Introduction
│   ├── references.bib        # Bibliography
│   ├── requirements.txt      # Python dependencies
│   └── chapters/             # Lecture notes
│       ├── lecture01_*.md
│       ├── lecture02_*.md
│       └── ...
├── content/                   # Original source files
├── deploy.sh                  # Deployment script
└── README.md                  # This file
```

## 📝 Contributing

Found a typo or error? Please:
1. Open an [issue](https://github.com/duymlcoding/FRE_6083/issues)
2. Submit a pull request with corrections

## 🔧 Building the Book

The book is built using [Jupyter Book](https://jupyterbook.org/), which provides:
- Beautiful, professional formatting
- LaTeX math rendering via MathJax
- Collapsible sections and interactive elements
- Mobile-responsive design
- Dark mode support

## 📖 Features

- **13 comprehensive lectures** covering quantitative methods in finance
- **Worked examples** with step-by-step solutions
- **Physical interpretations** of mathematical formulas
- **Practice problems** and exercises
- **Professional formatting** with Jupyter Book admonitions
- **LaTeX math** rendering for equations
- **References** to primary textbooks

## 📄 License

This work is licensed under [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

You are free to:
- **Share** — copy and redistribute the material
- **Adapt** — remix, transform, and build upon the material

Under the following terms:
- **Attribution** — You must give appropriate credit to Professor Agnès Tourin

## 👤 Author

**Professor Agnès Tourin**
NYU Tandon School of Engineering
Course: FRE 6083 - Quantitative Methods

## 📚 Recommended Textbooks

1. Sheldon Ross, "Introduction to Probability Models", 11th edition, Academic Press, 2014
2. Jean Jacod and Philip Protter, "Probability Essentials", 2nd Edition, Springer, 2004
3. Hull, J., "Options, Futures and Other Derivatives", Pearson/Prentice Hall

---

*Last updated: November 2025*
