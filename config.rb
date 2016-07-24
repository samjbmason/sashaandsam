###
# Page options, layouts, aliases and proxies
###

activate :directory_indexes

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
data.gifts.each do |gift|
  proxy "/#{gift.url}.html", '/buy-gift-template.html', locals: {
    id: gift.id,
    title: gift.title,
    price: gift.price,
    description: gift.description
  },
  ignore: true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  config[:stripe_publishable_key] = 'pk_test_lamQrESkqXdm9SffXRaVfc0W'
  config[:site_url] = 'http://sashaandsam-payment.dev'
end

# Methods defined in the helpers block are available in templates
helpers do
  def to_pennies(val)
    (val.to_f * 100).to_i
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir, 'fonts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  config[:stripe_publishable_key] = 'pk_live_HS4bsPxYf3REsuDr1GKUAz8z'
  config[:site_url] = 'https://sashaandsam-payment.herokuapp.com'
end
