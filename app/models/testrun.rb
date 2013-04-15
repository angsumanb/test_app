class Testrun < ActiveRecord::Base
  attr_accessible :description, :name, :testcase_ids

#  accepts_nested_attributes_for :testresults
  
  has_many :testresults
  has_many :testcases, :through => :testresults

  before_save { |testrun| testrun.name = name.upcase }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } 
  validates :description, presence: true
end
