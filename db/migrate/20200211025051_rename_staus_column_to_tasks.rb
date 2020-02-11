class RenameStausColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :Status, :status
  end
end
