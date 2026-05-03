# Migration from al-folio/Jekyll

Clone the existing repository and create a branch:

```sh
git clone git@github.com:DeviousCilantro/deviouscilantro.github.io.git
cd deviouscilantro.github.io
git switch main
git pull
git switch -c rust-wasm-academic-site
```

Unzip this package next to the repository, then replace the repository contents:

```sh
rsync -av --delete \
  --exclude='.git/' \
  --exclude='public/' \
  archisman-rust-wasm-site/ \
  deviouscilantro.github.io/
```

Add your headshot before deployment, if desired:

```sh
cp /path/to/square-headshot.jpg static/assets/img/archisman.jpg
```

Then set this in `content/site.toml`:

```toml
photo_path = "/assets/img/archisman.jpg"
photo_alt = "Portrait of Archisman Dutta"
```

Build locally:

```sh
rustup target add wasm32-unknown-unknown
cargo install wasm-pack --locked
./scripts/build.sh
python3 -m http.server --directory public 8000
```

Check `http://localhost:8000`, including `/cv/`, a narrow mobile-size viewport, and dark/light mode.

Commit and push:

```sh
git status
git add .
git commit -m "Replace al-folio with Rust-generated academic homepage"
git push -u origin rust-wasm-academic-site
```

Then open a pull request and merge once GitHub Pages builds successfully.

In GitHub repository settings, set Pages source to `GitHub Actions`.

The CV workflow is:

```sh
cd cv
latexmk -pdf cv.tex
cp cv.pdf ../static/assets/pdf/archisman-dutta-cv.pdf
cd ..
./scripts/build.sh
```

The public CV page embeds `static/assets/pdf/archisman-dutta-cv.pdf`. The `Open PDF` and `Download` buttons are fallback/convenience links, not the primary presentation.
