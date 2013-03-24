class Testcase < ActiveRecord::Base
  attr_accessible :comments, :estimate, :expectedresult, :preconditions, :priority, :steps, :title, :testtype

  belongs_to :suite

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

  validates :steps, presence: true
  validates :testtype, presence: true
  validates :priority, presence: true

  validates :suite_id, presence: true

end
