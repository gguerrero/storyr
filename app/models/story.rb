class Story < ActiveRecord::Base
  belongs_to :user
  has_many   :rates

  validates_presence_of   :title, :user_id
  validates_uniqueness_of :title
  validates               :title,       length: { within: 3..40 }
  validates               :description, length: { maximum: 140 }

  before_save :publishing_date
  before_save :unify_tags


  def publishing_date
    self.published_on ||= Date.today
  end
  private

  def unify_tags
    self.tags = self.tags.map{|tag| tag.downcase}.uniq
  end
end
