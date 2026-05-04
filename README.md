# Minimal Academic Website Template

A lightweight academic website template for researchers, graduate students, theorists, logicians, cryptographers, and anyone who wants a clean personal homepage without using Jekyll, al-folio, React, Astro, or a heavy frontend framework.

The site is built around a small Rust-based static generator, a single editable content file, optional Rust/WebAssembly enhancements, and MathJax for mathematical notation.

The guiding design principle is simple:

> Edit content in one place. Generate static HTML. Keep the website fast, readable, and maintainable.

This template is intended for academic homepages: research interests, papers, talks, teaching, service, CV, and contact information.

---

## Features

- Rust-based static site generation.
- Single source of truth for site content: `content/site.toml`.
- Optional Rust/WebAssembly layer for small interactive behavior such as dark/light mode.
- MathJax support for LaTeX-style mathematical notation.
- Responsive design for desktop, tablet, and mobile screens.
- Clean academic typography and spacing.
- Dark and light color schemes.
- No Jekyll.
- No Node.js frontend framework.
- No blog system unless you add one yourself.
- No database.
- No CMS.
- No client-side rendering requirement for core content.
- Suitable for GitHub Pages deployment.
- Easy to fork and adapt.

---

## Repository structure

```text
.
├── content/
│   └── site.toml              # Main editable content file
│
├── cv/
│   └── cv.tex                 # Optional LaTeX source for CV
│
├── scripts/
│   └── build.sh               # Build script
│
├── sitegen/
│   ├── Cargo.toml             # Rust static-site generator
│   └── src/
│       └── main.rs
│
├── static/
│   ├── assets/
│   │   ├── css/
│   │   │   └── site.css       # Main stylesheet
│   │   ├── img/
│   │   │   └── ...            # Portraits, favicons, images
│   │   ├── pdf/
│   │   │   └── ...            # CV and other PDFs
│   │   └── slides/
│   │       └── ...            # Talk slides
│   └── ...
│
├── templates/
│   ├── base.html              # Shared page shell
│   ├── index.html             # Homepage
│   ├── research.html          # Research page
│   └── talks.html             # Talks page
│
├── wasm/
│   ├── Cargo.toml             # Optional WebAssembly crate
│   └── src/
│       └── lib.rs
│
├── public/                    # Generated output; do not edit directly
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Pages deployment workflow
├── .gitignore
└── README.md
```

The generated website lives in `public/`. Do not edit files in `public/` manually; they are overwritten by the build script.

---

## Requirements

Install Rust:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Add the WebAssembly target:

```sh
rustup target add wasm32-unknown-unknown
```

Install `wasm-pack`:

```sh
cargo install wasm-pack --locked
```

For local preview, Python is sufficient:

```sh
python3 --version
```

Optional, for compiling the LaTeX CV:

```sh
latexmk --version
```

If `latexmk` is not installed, install a TeX distribution such as TeX Live or MacTeX.

---

## Quick start

Clone or fork the repository:

```sh
git clone https://github.com/YOUR-USERNAME/YOUR-REPO.git
cd YOUR-REPO
```

Edit the content file:

```text
content/site.toml
```

Build the site:

```sh
./scripts/build.sh
```

Preview locally:

```sh
python3 -m http.server --directory public 8000
```

Then open:

```text
http://localhost:8000
```

---

## Editing site content

All main site content is stored in:

```text
content/site.toml
```

This is the file you should edit most often.

A minimal example:

```toml
[person]
name = "Your Name"
title = "PhD Student in Computer Science"
affiliation = "Example University"
affiliation_url = "https://example.edu"
email = "you@example.edu"
location = "City, Country"
cv_path = "/assets/pdf/cv.pdf"
photo_path = "/assets/img/portrait.jpg"
photo_alt = "Portrait of Your Name"

intro = """
I am a PhD student in [Computer Science](https://example.edu/cs) at [Example University](https://example.edu).
My research interests are in cryptography, complexity theory, logic, and proof systems.
"""

[research]
heading = "Research"

summary = """
My current work concerns secure computation, proof systems, and the algebraic foundations of cryptography.
I am also interested in connections with complexity theory and logic.
"""

[[research.areas]]
name = "Cryptography"
description = "Secure multiparty computation, proof systems, pseudorandom correlation functions, and algebraic assumptions."

[[research.areas]]
name = "Complexity Theory"
description = "TFNP, reductions, proof complexity, and structural questions around cryptographic hardness."

[[papers]]
title = "Example Paper Title"
authors = [
  { name = "Your Name", url = "/" },
  { name = "Coauthor Name", url = "https://example.edu/coauthor" }
]
venue = "Manuscript"
year = "2026"
summary = "Short description of the result."
links = [
  { label = "paper", url = "/assets/pdf/example-paper.pdf" },
  { label = "eprint", url = "https://eprint.iacr.org/" }
]

[[talks]]
title = "Example Talk Title"
venue = "Example Seminar"
venue_url = "https://example.edu/seminar"
date = "May 2026"
location = "Example University"
links = [
  { label = "slides", url = "/assets/slides/example-talk.pdf" }
]
```

The generator reads this file and renders static HTML pages.

---

## Markdown in content

Most long text fields support Markdown.

For example:

```toml
intro = """
I am a PhD student at [Example University](https://example.edu), advised by
[Advisor Name](https://example.edu/advisor).
"""
```

This renders links normally in the generated HTML.

Use Markdown sparingly. Academic homepages usually read better when they are plain and direct.

---

## Mathematical notation

The site supports MathJax.

Inline math:

```toml
summary = """
I study pseudorandom correlation functions for \( \mathrm{VOLE} \) and assumptions such as \( \mathrm{DCR} \).
"""
```

Display math:

```toml
summary = """
A typical relation is written as
\[
  y = ax + b.
\]
"""
```

For acronyms such as VOLE, DCR, LPN, LWE, MPC, and SNARKs, ordinary text is often preferable unless the expression is genuinely mathematical:

```toml
summary = """
I study pseudorandom correlation functions for VOLE from the DCR assumption.
"""
```

---

## Adding a portrait

Place your portrait in:

```text
static/assets/img/
```

For example:

```text
static/assets/img/portrait.jpg
```

Then edit:

```toml
[person]
photo_path = "/assets/img/portrait.jpg"
photo_alt = "Portrait of Your Name"
```

A square or near-square image works best.

To remove the portrait entirely, leave the path empty:

```toml
photo_path = ""
```

---

## Adding or updating the CV

Place the public CV PDF at:

```text
static/assets/pdf/cv.pdf
```

Then set:

```toml
[person]
cv_path = "/assets/pdf/cv.pdf"
```

The homepage can render this as a simple download button.

If you maintain the CV in LaTeX, keep the source in:

```text
cv/cv.tex
```

Compile it with:

```sh
cd cv
latexmk -pdf cv.tex
```

Then copy the generated PDF:

```sh
cp cv.pdf ../static/assets/pdf/cv.pdf
```

Return to the repository root and rebuild:

```sh
cd ..
./scripts/build.sh
```

---

## Adding talk slides

Put slides in:

```text
static/assets/slides/
```

For example:

```text
static/assets/slides/example-talk.pdf
```

Then add a link in `content/site.toml`:

```toml
[[talks]]
title = "Example Talk"
venue = "Example Seminar"
date = "May 2026"
location = "Example University"
links = [
  { label = "slides", url = "/assets/slides/example-talk.pdf" }
]
```

External slide links also work:

```toml
links = [
  { label = "slides", url = "https://example.edu/slides.pdf" }
]
```

---

## Adding papers and manuscripts

Add papers in `content/site.toml` using repeated `[[papers]]` entries.

Example:

```toml
[[papers]]
title = "A Short and Serious Paper Title"
authors = [
  { name = "Your Name", url = "/" },
  { name = "Second Author", url = "https://example.edu/second-author" }
]
venue = "Manuscript"
year = "2026"
summary = "One or two sentences describing the contribution."
links = [
  { label = "paper", url = "/assets/pdf/paper.pdf" },
  { label = "code", url = "https://github.com/example/repo" }
]
```

For unpublished work, use:

```toml
venue = "Manuscript"
```

or:

```toml
venue = "In preparation"
```

Avoid over-explaining unpublished work on the homepage. A short, precise description is usually better.

---

## Navigation

The main navigation is defined in the templates, usually in:

```text
templates/base.html
```

A minimal academic navigation might look like:

```html
<nav>
  <a href="/">Home</a>
  <a href="/research/">Research</a>
  <a href="/talks/">Talks</a>
</nav>
```

CV, GitHub, Google Scholar, ORCID, and email links can be placed on the homepage or footer instead of in the main navigation.

This keeps the header clean.

---

## Styling

The main stylesheet is:

```text
static/assets/css/site.css
```

Most of the visual design is controlled by CSS variables.

Example:

```css
:root {
  --bg: #f4f1ea;
  --text: #1c1c1c;
  --muted: #6b6b6b;
  --link: #2c3e50;
  --border: #d8d2c5;
}

[data-theme="dark"] {
  --bg: #1a1a1a;
  --text: #e8e6e3;
  --muted: #a8a39a;
  --link: #c0a060;
  --border: #3a3a3a;
}
```

Edit these variables to change the color scheme.

The template is designed to work well with muted, academic color palettes. Avoid high-saturation colors unless you intentionally want a more personal/portfolio-like style.

---

## Typography

The template can use a restrained serif stack by default:

```css
body {
  font-family: Georgia, "Times New Roman", serif;
}
```

For headings, you can use a more distinctive serif font such as Cinzel:

```html
<link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600&display=swap" rel="stylesheet">
```

Then:

```css
h1, h2, h3, .site-title {
  font-family: "Cinzel", Georgia, serif;
  letter-spacing: 0.03em;
}
```

Use decorative fonts sparingly. A small amount of typographic distinction in headings is usually enough.

---

## Dark/light mode

The optional WebAssembly crate controls theme toggling.

The recommended behavior is:

1. Check whether the user has already selected a theme.
2. Otherwise respect the system preference.
3. Store the chosen theme in `localStorage`.
4. Apply the theme using a `data-theme` attribute on the document root.

The resulting HTML looks like:

```html
<html data-theme="dark">
```

or:

```html
<html data-theme="light">
```

The CSS then uses:

```css
[data-theme="dark"] {
  --bg: #1a1a1a;
  --text: #e8e6e3;
}
```

The website should remain usable even if WebAssembly fails to load. Core content is generated as static HTML.

---

## Build process

The build script performs three tasks:

1. Build the WebAssembly package.
2. Run the Rust static-site generator.
3. Copy static assets into `public/`.

Typical command:

```sh
./scripts/build.sh
```

The generated output appears in:

```text
public/
```

Preview locally with:

```sh
python3 -m http.server --directory public 8000
```

---

## Deployment with GitHub Pages

This template is designed for GitHub Pages deployment through GitHub Actions.

The deployment workflow is located at:

```text
.github/workflows/deploy.yml
```

A typical workflow has the following structure:

```yaml
name: Deploy site

on:
  push:
    branches: ["main"]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install Rust
        uses: dtolnay/rust-toolchain@stable
        with:
          targets: wasm32-unknown-unknown

      - name: Install wasm-pack
        run: cargo install wasm-pack --locked

      - name: Build
        run: ./scripts/build.sh

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

In the GitHub repository settings:

1. Go to **Settings**.
2. Open **Pages**.
3. Set **Build and deployment** to **GitHub Actions**.
4. Push to `main`.

After a successful workflow run, the website is published through GitHub Pages.

---

## Custom domain

To use a custom domain, configure it in GitHub Pages settings.

For example:

```text
example.org
```

If using an apex domain, configure DNS records with your DNS provider according to GitHub Pages instructions.

For a `www` subdomain, configure a CNAME record pointing to:

```text
YOUR-USERNAME.github.io
```

If using Cloudflare, it is often easiest to set the DNS records to DNS-only while GitHub provisions HTTPS. Once HTTPS is working, adjust Cloudflare settings as needed.

---

## Making this your own

To adapt the template:

1. Replace the content in `content/site.toml`.
2. Replace the CV PDF in `static/assets/pdf/`.
3. Replace the portrait in `static/assets/img/`.
4. Edit the color variables in `static/assets/css/site.css`.
5. Edit templates only if you want structural changes.
6. Run `./scripts/build.sh`.
7. Preview locally.
8. Push to GitHub.

Most users should not need to edit the Rust generator unless they want to change the content schema or add new page types.

---

## Recommended content style

Academic homepages are usually strongest when they are concise.

Prefer:

```text
I am a PhD student in Computer Science at Example University.
My research interests are in cryptography and complexity theory.
```

Avoid:

```text
I am deeply passionate about using cutting-edge mathematical tools to revolutionize the future of secure computation.
```

Prefer concrete sections:

- Research interests
- Papers
- Talks
- Teaching
- Service
- CV
- Contact

Avoid excessive sections:

- Projects unrelated to research
- Long coursework lists
- Personal manifestos
- Overly detailed news feeds
- Large icon grids
- Blog machinery unless you actually maintain a blog

---

## Development notes

The core website should remain static.

The Rust generator is responsible for:

- Reading `content/site.toml`.
- Rendering templates.
- Writing HTML files to `public/`.
- Copying static assets.

The WebAssembly crate should remain small and optional.

Good uses for WASM:

- Theme toggle.
- Small UI state.
- Minor client-side enhancements.

Poor uses for WASM:

- Rendering all main content.
- Fetching all site data at runtime.
- Replacing static HTML for ordinary pages.
- Making the homepage unusable without JavaScript or WASM.

This keeps the site fast, accessible, and archival.

---

## Troubleshooting

### The site does not build

Make sure Rust is installed:

```sh
rustc --version
cargo --version
```

Make sure the WebAssembly target is installed:

```sh
rustup target add wasm32-unknown-unknown
```

Make sure `wasm-pack` is installed:

```sh
wasm-pack --version
```

Then rebuild:

```sh
./scripts/build.sh
```

---

### Math is not rendering

Check that MathJax is loaded in `templates/base.html`.

Also check that your delimiters are correct.

Inline math:

```text
\( x + y \)
```

Display math:

```text
\[
x + y
\]
```

Inside TOML strings, prefer multiline strings:

```toml
summary = """
I study objects such as \( \mathrm{VOLE} \) and \( \mathrm{DCR} \).
"""
```

---

### The portrait does not appear

Check that the file exists:

```text
static/assets/img/portrait.jpg
```

Check that `content/site.toml` points to it:

```toml
photo_path = "/assets/img/portrait.jpg"
```

Then rebuild:

```sh
./scripts/build.sh
```

---

### The CV button is broken

Check that the PDF exists:

```text
static/assets/pdf/cv.pdf
```

Check the content file:

```toml
cv_path = "/assets/pdf/cv.pdf"
```

Then rebuild.

---

### Dark mode does not persist

Check that the WASM package is being built and copied correctly.

Also check that the browser allows `localStorage`.

The site should still work without dark-mode persistence.

---

### GitHub Pages deployed the old site

Check the GitHub Actions tab.

The deployment is updated only after the workflow succeeds.

Also check that GitHub Pages is configured to use **GitHub Actions**, not “Deploy from branch.”

If using Cloudflare or another CDN, purge the cache or hard-refresh the browser.

---

## Git hygiene

The generated output should usually not be committed unless you intentionally deploy from a branch.

Recommended `.gitignore` entries:

```gitignore
/public/
/target/
sitegen/target/
wasm/target/
.DS_Store
*.aux
*.fdb_latexmk
*.fls
*.log
*.out
*.synctex.gz
```

Commit source files, not generated build artifacts.

---

## License

Choose a license depending on how you want others to use the template.

For a permissive template license, use MIT:

```text
MIT License
```

For the website content itself, you may want a different license or no explicit reuse permission.

A common setup is:

- Code: MIT License.
- Personal content, CV, papers, images: all rights reserved unless otherwise stated.

You can state this explicitly:

```text
The source code for this template is available under the MIT License.
Personal content, CVs, papers, and images are not covered by the template license unless explicitly stated.
```

---

## Acknowledgments

This template is designed for clean academic homepages in the style of traditional theory, logic, and cryptography websites: minimal navigation, readable typography, static content, and no unnecessary interface machinery.

It is intentionally small. Add complexity only when the site genuinely needs it.
