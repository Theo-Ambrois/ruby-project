class Post < ApplicationRecord
  validates_presence_of :title, :content
  validates :content, length:  {minimum: 10}
end
