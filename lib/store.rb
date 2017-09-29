class Store < ActiveRecord::Base
has_and_belongs_to_many(:brands)
validates(:name, {:presence => true, :uniqueness => true})
before_save(:word_format)

  def word_format
    self.name = self.name.capitalize()
  end
end
