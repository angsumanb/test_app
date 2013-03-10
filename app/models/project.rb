# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base
  attr_accessible :description, :name

  before_save { |project| project.name = name.upcase }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } 
  validates :description, presence: true
end
