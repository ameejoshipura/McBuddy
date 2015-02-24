class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio

      t.string :qbid

      t.string :classlist
      t.string :schedule

      t.timestamps null: false
    end
  end
end
