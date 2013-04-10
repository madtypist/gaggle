class RenameDescColumn < ActiveRecord::Migration
  def change
    rename_column :movies, :desc, :summary
  end
end
