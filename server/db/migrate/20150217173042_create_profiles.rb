class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio

      t.string :pid
      t.string :qbid

      t.reference :classlistref
      t.reference :scheduleref

      t.timestamps null: false
    end
  end
end
