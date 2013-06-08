class Testcase < ActiveRecord::Base
  attr_accessible :zip, :photo, :comments, :estimate, :expectedresult, :preconditions, :priority, :steps, :title, :testtype

  has_attached_file :photo , :styles =>       { :small => "50x50>" }, :url  => "/assets/testcases/:id/:style/:basename.:extension", :path => ":rails_root/public/assets/testcases/:id/:style/:basename.:extension"

  has_attached_file :zip ,  :url  => "/assets/testcases/:id/:style/:basename.:extension", :path => ":rails_root/public/assets/testcases/:id/:style/:basename.:extension"
  

  belongs_to :suite
  has_many :testresults, dependent: :destroy
  has_many :testruns, :through => :testresults


  before_save { |testcase| testcase.title = title.capitalize }  


  TTOPTIONS = ['Functionality', 'Regression', 'Performance', 'Usability', 'Other']
  PROPTIONS = ['High', 'Medium', 'Low', 'Unknown']

  validates :title, presence: true, length: { maximum: 200 }, uniqueness: { case_sensitive: false }

#  validates :steps, presence: true
  validates :testtype, presence: true
  validates :priority, presence: true
  validates_inclusion_of :testtype, :in => TTOPTIONS
  validates_inclusion_of :priority, :in => PROPTIONS

  validates :suite_id, presence: true

  default_scope order: 'testcases.created_at DESC'
end
