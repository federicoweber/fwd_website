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
npm run deploy
```

This builds the app and pushes the contents of `dist/` (including `CNAME`) to the
`master` branch of the `federicoweber.github.io` repo via the
[`gh-pages`](https://www.npmjs.com/package/gh-pages) package. Requires push access
to that repo over SSH.

---

federicoweber (c) by Federico Weber

This website and its content is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
Attribution-NonCommercial-ShareAlike 4.0 International
