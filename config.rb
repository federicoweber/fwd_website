require "extensions/views"

activate :views
activate :directory_indexes

set :relative_links, true
set :css_dir, 'assets/style'
set :js_dir, 'assets/js'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'
set :layout, 'layouts/application'
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :footnotes => true
activate :syntax

activate :blog do |blog|
  blog.prefix = "notes"
  blog.permalink = "{title}.html"
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.layout = "layouts/blog"

  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "p{num}"
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-11721887-1'
  ga.minify = true
end

configure :development do
 activate :livereload
end


configure :build do
  # Relative assets needed to deploy to Github Pages
  activate :relative_assets
  # activate :favicon_maker, :icons => {
  #   "favicon/favicon_template.svg" => [
  #     { icon: "apple-touch-icon-152x152-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
  #     { icon: "apple-touch-icon-144x144-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
  #     { icon: "apple-touch-icon-120x120-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
  #     { icon: "apple-touch-icon-114x114-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
  #     { icon: "apple-touch-icon-76x76-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
  #     { icon: "apple-touch-icon-72x72-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
  #     { icon: "apple-touch-icon-60x60-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
  #     { icon: "apple-touch-icon-57x57-precomposed.png" },               # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
  #     { icon: "apple-touch-icon-precomposed.png", size: "57x57" },      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
  #     { icon: "apple-touch-icon.png", size: "57x57" },                  # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
  #     { icon: "favicon-196x196.png" },                                  # For Android Chrome M31+.
  #     { icon: "favicon-160x160.png" },                                  # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
  #     { icon: "favicon-96x96.png" },                                    # For Google TV.
  #     { icon: "favicon-32x32.png" },                                    # For Safari on Mac OS.
  #     { icon: "favicon-16x16.png" },                                    # The classic favicon, displayed in the tabs.
  #     { icon: "favicon.png", size: "16x16" },                           # The classic favicon, displayed in the tabs.
  #     { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },         # Used by IE, and also by some other browsers if we are not careful.
  #     { icon: "mstile-70x70.png", size: "70x70" },                      # For Windows 8 / IE11.
  #     
  #   ]
  # }
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
  deploy.remote   = 'git@github.com:federicoweber/federicoweber.github.io.git'
  deploy.branch   = 'master'
end

helpers do
  def nav_link(link_text, page_url, options = {})
    options[:class] ||= ""
    if current_page.url.length > 1
      current_url = current_page.url.chop
    else
      current_url = current_page.url
    end
    options[:class] << " active" if page_url == current_url
    link_to(link_text, page_url, options)
  end
end
