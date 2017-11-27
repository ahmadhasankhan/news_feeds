class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  self.per_page = 50
  default_scope -> { order(created_at: :desc) }
  scope :by_feed_type, -> (type) { where(trackable_type: type) }
  scope :by_action_types, -> (types) { where(action: types) }

  def self.preload_conditions
    includes(:user,  comments: [:user])
  end
end
