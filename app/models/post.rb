class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  DEFAULT_PAGE_LIMIT = 50

  # By default fetching in descending order, however, we can always override the default scope using unscoped method
  default_scope -> { order(created_at: :desc) }

  # We can reuse this anywhere and pass the different limit as per the need, By default limit is 50
  scope :most_recent, ->(limit = DEFAULT_PAGE_LIMIT) { preload_conditions.limit(limit) }

  # This will preload related objects
  def self.preload_conditions
    includes(:user, comments: [:user])
  end
end
