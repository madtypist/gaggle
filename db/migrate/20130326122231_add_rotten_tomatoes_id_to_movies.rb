class AddRottenTomatoesIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :rt_id, :integer
  end
end
