class Testrun < ActiveRecord::Base
  attr_accessible :description, :name, :testcase_ids

#  accepts_nested_attributes_for :testresults
  
  has_many :testresults, dependent: :destroy
  has_many :testcases, :through => :testresults

  before_save { |testrun| testrun.name = name.capitalize }

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } 
  validates :description, presence: true
  default_scope order: 'testruns.created_at DESC'
end
