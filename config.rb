###
# Page options, layouts, aliases and proxies
###

activate :directory_indexes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def to_pennies(val)
    (val.to_f * 100).to_i
  end
end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'images'

set :fonts_dir, 'fonts'

# Build-specific configuration
configure :build do

  # Use relative URLs
  activate :relative_assets
end

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'webpack --bail' : 'webpack --watch -d',
  source: '.tmp',
  latency: 3
