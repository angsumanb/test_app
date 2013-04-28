class Pod < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :project
  has_many :suites, dependent: :destroy
#  has_many :testcases through: :suites

  before_save { |pod| pod.name = name.upcase }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :project_id, presence: true

  default_scope order: 'pods.created_at DESC'
end
