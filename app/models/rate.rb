class Rate < ActiveRecord::Base
  belongs_to :story
  belongs_to :user

  validates_presence_of :value, :story_id, :user_id
  validates             :value, inclusion: (1..10)

  before_save :rating_date

  private
  def rating_date
    self.rated_on ||= Date.today
  end
end
