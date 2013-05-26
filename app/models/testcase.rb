class Testcase < ActiveRecord::Base
  attr_accessible :comments, :estimate, :expectedresult, :preconditions, :priority, :steps, :title, :testtype

  belongs_to :suite
  has_many :testresults, dependent: :destroy
  has_many :testruns, :through => :testresults

   before_save { |testcase| testcase.title = title.capitalize }  
#  accepts_nested_attributes_for :testresults


  TTOPTIONS = ['Functionality', 'Regression', 'Performance', 'Usability', 'Other']
  PROPTIONS = ['High', 'Medium', 'Low', 'Unknown']

  validates :title, presence: true, length: { maximum: 200 }, uniqueness: { case_sensitive: false }

  validates :steps, presence: true
  validates :testtype, presence: true
  validates :priority, presence: true
  validates_inclusion_of :testtype, :in => TTOPTIONS
  validates_inclusion_of :priority, :in => PROPTIONS

  validates :suite_id, presence: true

  default_scope order: 'testcases.created_at DESC'
end
