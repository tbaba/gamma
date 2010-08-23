class AddWeightToTodo < ActiveRecord::Migration
  def self.up
    add_column :todos, :weight, :integer
  end

  def self.down
    remove_column :todos, :weight, :integer
  end
end
