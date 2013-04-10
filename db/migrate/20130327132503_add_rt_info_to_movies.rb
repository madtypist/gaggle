class AddRtInfoToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :imdb_id, :integer
    add_column :movies, :poster_location, :string
  end
end
