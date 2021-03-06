class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands

  validates(:name, {:presence => true, :length => {:maximum => 100}})
end
