class Project < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :pods, dependent: :destroy

  before_save { |project| project.name = name.capitalize }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } 
  validates :description, presence: true
end
