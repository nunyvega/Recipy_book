require 'csv'

class Cookbook
  attr_accessor :recipes, :csv_file_path
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(name: row[0], description: row[1], time: row[2], dif: row[3])
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    # save recipes to CSV
    csv_loop
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    csv_loop
  end

  def done(index)
    @recipes[index].mark_as_done!
    csv_loop
  end

  private

  def csv_loop
    CSV.open(@csv_file_path, 'w', @csv_options) do |csv_object|
      @recipes.each do |row_array|
        csv_object << [row_array.name, row_array.description, row_array.time, row_array.done, row_array.dif]
      end
    end
  end
end


