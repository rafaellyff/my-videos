class Comment < ActiveRecord::Base
  belongs_to :video

  validates :author, :text, presence: true

  before_create do
    self.date = Date.today
  end
end
