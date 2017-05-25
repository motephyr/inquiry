SitemapGenerator::Sitemap.default_host = Setting.domain

 # The directory to write sitemaps to locally
 #SitemapGenerator::Sitemap.public_path = 'tmp/'

 # Set this to a directory/path if you don't want to upload to the root of your `sitemaps_host`
 #SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'



SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  add works_path, :priority => 0.9, :changefreq => 'daily'
  
  Work.find_each do |work|
    add work_path(work), :lastmod => work.updated_at
  end

  User.find_each do |i|
    if i.user_info.present?
      add user_info_path(i), :lastmod => i.user_info.updated_at
    end
  end
end
