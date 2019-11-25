# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :user_events, foreign_key: :attended_event_id
  has_many :attendees, through: :user_events, foreign_key: :attendee_id
  validates :date_event, presence: true
  default_scope -> { order(date_event: :asc) }
  scope :upcoming, -> { where('date_event >= ?', Time.zone.now) }
  scope :past, -> { where('date_event < ?', Time.zone.now) }
end
