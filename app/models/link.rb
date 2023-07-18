class Link < ApplicationRecord
    validates_presence_of :url  
    validates :url, format: URI::regexp(%w[http https])  
    validates_uniqueness_of :slug

    before_validation :generate_slug
  
    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.blank?
        true
    end

    def short
        Rails.application.routes.url_helpers.short_url(slug: self.slug)
    end

    # the API
    def self.shorten(url, slug = '')
        link = find_by(url: url)
        return link.short if link

        link = new(url: url, slug: slug)
        return link.short if link.save

        shorten(url, slug + SecureRandom.uuid[0..2])
    end
end
