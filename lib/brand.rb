class Brand < ActiveRecord::Base
  has_and_belongs_to_many(:stores)
  validates(:name)
  before_save(:word_format)

  def word_format
    self.name = self.name.capitalize()
  end
end
