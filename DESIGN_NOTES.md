# Design notes

This site deliberately avoids the common al-folio/minimal-mistakes/portfolio look. The design target is an academic theory/cryptography homepage: clear hierarchy, restrained typography, compact navigation, sparse content, and low visual noise.

The main page is not a blog and not a project portfolio. Projects should appear only when they are attached to a paper, seminar, or software artifact with academic relevance.

The page uses a two-column desktop layout: identity/contact on the left and academic content on the right. On smaller screens, it collapses to one column. The CV page uses a wider one-column layout because embedded PDFs need horizontal space.

The CV is intentionally narrowed. The current CV contains useful material, but high-school awards, broad skills lists, implementation projects, and unlinked write-ups compete with the strongest signal: Ph.D. status, advisors, research experience, manuscript, teaching, and service. The LaTeX CV keeps the latter and compresses the former.

The portrait slot is optional. A professional headshot helps the page feel less empty at the pre-publication stage, but it should be a restrained square crop rather than a large hero photograph. The dark/light toggle is deliberately small and text-based, matching the academic visual language rather than adding a conspicuous UI widget.

Links are intentionally textual rather than icon-based. Institution names, advisor names, coauthor names, seminar names, and conference names can be linked directly from `content/site.toml`, which keeps editing lightweight while avoiding a portfolio-style social icon strip.

The embedded CV is meant for convenience, not lock-in. Visitors can read it in the browser, open the raw PDF in a new tab, or download it. Editing instructions belong in `README.md`, not on the public CV page.
