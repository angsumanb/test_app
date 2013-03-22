class Suite < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :pod


  before_save { |suite| suite.name = name.upcase }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :pod_id, presence: true

  default_scope order: 'suites.created_at DESC'
end