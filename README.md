# Archisman Dutta — academic homepage

This is a replacement for the current Jekyll/al-folio site. It is intentionally small: a Rust static-site generator, a tiny Rust/WASM progressive-enhancement crate, static CSS, MathJax, and a LaTeX CV. The WASM layer marks the active navigation item and handles the dark/light color-scheme switch.

The site is meant to read like a theory/cryptography academic homepage rather than a portfolio. It keeps the public surface to identity, research interests, manuscripts, teaching, service, and CV. It deliberately removes blog machinery, project-card machinery, social widgets, repository showcases, and theme scaffolding.

## Architecture

```text
content/site.toml              editable academic content
cv/cv.tex                      LaTeX CV source
static/assets/css/site.css     site styling
static/assets/img/             optional portrait/headshot
static/assets/pdf/             compiled CV PDF
templates/                     HTML templates rendered by Rust
sitegen/                       Rust static-site generator
wasm/                          small Rust/WASM enhancer
public/                        generated output, not committed by default
```

The site is not a client-side single-page application. The important text is emitted as static HTML for accessibility, indexing, and durability. WASM is only an enhancement layer. MathJax is loaded only for TeX/LaTeX notation.

## Edit routine

Most ordinary updates happen in one file:

```sh
$EDITOR content/site.toml
```

Add papers under `research.manuscripts`, update the left-column research title via `research.heading`, update research directions under `research.directions`, and update teaching/service/news in their corresponding arrays.

Most public text fields accept Markdown links. The homepage intro, research summary, news items, teaching descriptions, and research-direction descriptions are rendered through Markdown or inline Markdown filters, so links can be written as `[Aarhus University](https://international.au.dk/)`. For structured fields, use the corresponding URL field, for example `affiliation_url`, `institution_url`, `venue_url`, and manuscript author `{ name = ..., url = ... }` entries. MathJax notation can be written as `\(\mathsf{VOLE}\)` for inline math or `\[ ... \]` for display math.

To add a portrait, place a square image under `static/assets/img/`, for example `static/assets/img/archisman.jpg`, then set `photo_path = "/assets/img/archisman.jpg"` in `content/site.toml`. Leave `photo_path = ""` to omit the portrait block.

To add slides for a talk, put the PDF under `static/assets/slides/` and add a link in `content/site.toml`:

```toml
[[talks]]
title = "Private Originator Tracing in End-to-End Encrypted Messaging"
venue = "Aarhus Crypto Seminar"
venue_url = "https://cs.au.dk/research/cryptography-and-cyber-security/seminar"
date = "Jun 2025"
links = [
  { label = "slides", url = "/assets/slides/atavism-aarhus-crypto-seminar.pdf" }
]
```

External slide links also work by replacing the URL with `https://...`.

The CV page embeds the compiled PDF in the browser and also exposes small `Open PDF` and `Download` controls. Do not put maintenance instructions in `templates/cv.html`; keep workflow notes in this README.

The color-scheme switch is implemented in `wasm/src/lib.rs`. CSS supports system dark mode by default; when a visitor toggles the button, the chosen `light`/`dark` value is stored in browser local storage.

For CV updates:

```sh
cd cv
latexmk -pdf cv.tex
cp cv.pdf ../static/assets/pdf/archisman-dutta-cv.pdf
```

## Local build

Install Rust, then:

```sh
rustup target add wasm32-unknown-unknown
cargo install wasm-pack --locked
./scripts/build.sh
python3 -m http.server --directory public 8000
```

Open `http://localhost:8000`.

If `wasm-pack` is not installed, the static HTML still builds; the tiny WASM enhancement simply will not be present.

## GitHub Pages

Use GitHub Pages with `Source: GitHub Actions`, not Jekyll. The workflow in `.github/workflows/deploy.yml` builds `public/` and deploys that directory.

The root `CNAME` contains:

```txt
archisman.org
```

Keep it if `archisman.org` remains the canonical domain.

## DNS notes

For an apex GitHub Pages domain, use GitHub's current A records for `@` and a CNAME from `www` to `DeviousCilantro.github.io`. In Cloudflare, keep records DNS-only while GitHub provisions HTTPS, then enable HTTPS in repository settings.

## Design notes

The visual target is: quiet, mathematical, and institutional. It uses system fonts, a restrained serif for identity/headings, no cards except the identity/CV panels, no theme badges, no animated portfolio effects, and no social-feed surface.

The public site should remain sparse until publications accumulate. A small site with one manuscript and precise research interests is stronger than a large site with under-specified projects.
