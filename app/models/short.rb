class Short < ApplicationRecord
  has_secure_token :url_digest

  validates :url, presence: true, uniqueness: true

end
