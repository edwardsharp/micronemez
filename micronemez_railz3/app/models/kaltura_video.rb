class KalturaVideo < ActiveRecord::Base
  def thumbnail_url
    return self.thumbnailUrl
  end
end
