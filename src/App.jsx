function Header() {
  return (
    <header id="main_header">
      <div id="main_header--content">
        <nav id="main_nav">
          <h1 id="main_header--title">
            <a href="/">Federico Weber</a>
          </h1>
        </nav>
      </div>
    </header>
  )
}

function Hero() {
  return (
    <div className="main_content">
      <div id="homepage--about">
        <div className="homepage--about--content">
          <h1 id="about_plate">
            <span id="about_plate--content">
              <span id="about_plate--des">
                <b>Designer &amp;</b>
              </span>
              <span id="about_plate--dev">
                <b>Developer</b>
              </span>
              <span id="about_plate--hand">handcrafting </span>
              <span id="about_plate--web">websites &amp; apps.</span>
            </span>
          </h1>
        </div>
      </div>
    </div>
  )
}

function Footer() {
  return (
    <footer id="main_footer">
      <ul>
        <li>
          <a href="https://github.com/federicoweber" title="github" target="_blank" rel="noreferrer">
            <i className="fa fa-github" />
          </a>
        </li>
        <li>
          <a href="https://instagram.com/federicoweber" title="instagram" target="_blank" rel="noreferrer">
            <i className="fa fa-instagram" />
          </a>
        </li>
        <li>
          <a href="https://linkedin.com/in/federicoweber" title="linkedin" target="_blank" rel="noreferrer">
            <i className="fa fa-linkedin" />
          </a>
        </li>
        <li>
          <a href="https://www.pinterest.com/federicoweber/" title="pinterest" target="_blank" rel="noreferrer">
            <i className="fa fa-pinterest" />
          </a>
        </li>
        <li>
          <a href="https://twitter.com/federicoweber" title="twitter" target="_blank" rel="noreferrer">
            <i className="fa fa-twitter" />
          </a>
        </li>
        <li className="-with_text -push_right">
          <a href="mailto:federicoweber@gmail.com" title="email">
            <span className="text">email me</span>
            <i className="fa fa-envelope-o" />
          </a>
        </li>
        <li className="-with_text">
          <a
            href="http://creativecommons.org/licenses/by-nc-sa/4.0/"
            title="Attribution-NonCommercial-ShareAlike 4.0 International"
            target="_blank"
            rel="noreferrer"
          >
            <span className="text">license</span>
            <i className="fa fa-creative-commons" />
          </a>
        </li>
      </ul>
    </footer>
  )
}

export default function App() {
  return (
    <div id="wrapper">
      <Header />
      <Hero />
      <Footer />
    </div>
  )
}
