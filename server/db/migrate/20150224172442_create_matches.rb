class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :profile, index: true

      t.timestamps null: false
    end
    add_foreign_key :matches, :profiles
  end
end
