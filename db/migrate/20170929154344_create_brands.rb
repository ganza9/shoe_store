class CreateBrands < ActiveRecord::Migration
  def change
    create_table(:brands) do |t|
      t.column(:name, :string)
      t.column(:price, :int)

      t.timestamps()
    end
  end
end
