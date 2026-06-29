# federicoweber.com

Personal website — a statically-deployed single-page [React](https://react.dev/) app
built with [Vite](https://vite.dev/).

## Develop

```bash
npm install
npm run dev      # start the dev server (http://localhost:5173)
```

## Build

```bash
npm run build    # outputs static files to dist/
npm run preview  # preview the production build locally
```

## Deploy

The site is hosted on GitHub Pages from the
[`federicoweber/federicoweber.github.io`](https://github.com/federicoweber/federicoweber.github.io)
repo (custom domain `federicoweber.com`).

```bash
npm run deploy           # build everything and push to GitHub Pages
DRY_RUN=1 npm run deploy  # assemble dist/ locally without pushing
```

This runs [`deploy.sh`](./deploy.sh), which builds the main site **and** the
sibling projects in this folder, then pushes the combined `dist/` (including
`CNAME`) to the `master` branch of the `federicoweber.github.io` repo via the
[`gh-pages`](https://www.npmjs.com/package/gh-pages) package. Requires push
access to that repo over SSH.

### Sub-projects

Each sibling project is built with its Vite `base` set to its sub-path and
copied into `dist/projects/<slug>/`, so it ships in the same commit:

| Source folder      | Published at                                          |
| ------------------ | ----------------------------------------------------- |
| `md_labels_maker`  | `https://federicoweber.com/projects/minidisc-labels/` |
| `spotify_recorder` | `https://federicoweber.com/projects/album-sequencer/` |

The Spotify build bakes in the app's Client ID (a public PKCE identifier, not a
secret) and the production redirect URI. For login to work, the Spotify
dashboard must list `https://federicoweber.com/projects/album-sequencer/` as a
redirect URI, and — until the app has Extended Quota Mode — each user's email
must be allowlisted there (max 25). To add or rename a sub-project, edit the
`build_subproject` calls in `deploy.sh`.

---

federicoweber (c) by Federico Weber

This website and its content is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
Attribution-NonCommercial-ShareAlike 4.0 International
