class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :summary
      t.string :detail
      t.integer :progress
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
