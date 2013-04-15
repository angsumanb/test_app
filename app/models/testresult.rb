class Testresult < ActiveRecord::Base
  attr_accessible :status, :comments, :testcase_id, :testrun_id

  belongs_to :testrun
  belongs_to :testcase  

  #before_save { |testresult| testresult.status = name.upcase }
  before_save :default_status

#  validates :status, presence: true
  
  SOPTIONS = ['Passed', 'Failed', 'Blocked', 'Retest', 'Pending']
#  validates_inclusion_of :status, :in => SOPTIONS


  def default_status
    self.status ||= 'Pending'
  end
end
