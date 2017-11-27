class Newsfeed < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  scope :latest, -> { order('created_at desc') }
  scope :by_feed_type, -> (type) { where(:trackable_type => type.capitalize) }
  scope :by_action_type, -> (type) { where(:action => type.downcase) }
end
