class CreateNewsfeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :newsfeeds do |t|
      t.belongs_to :user, foreign_key: true
      t.string :action
      t.belongs_to :trackable, polymorphic: true

      t.timestamps
    end
  end
end
