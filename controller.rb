require 'nokogiri'
require 'open-uri'
require_relative 'recipe'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.print_recipes(recipes)
  end

  def create
    content = @view.add_new_recipe
    receta = Recipe.new(name: content[0], description: content[1], time: content[2], dif: content[3])
    @cookbook.add_recipe(receta)
  end

  def destroy
    index = @view.remove_recipe
    @cookbook.remove_recipe(index)
  end

  def import
    ingredient = @view.ingredient
    first_five = html_results(ingredient)
    index_selection = @view.give_imported_recipe_options(first_five)
    @cookbook.add_recipe(first_five[index_selection])
  end

  def done
    list
    index = @view.mark_done
    @cookbook.done(index)
  end

  private

  def html_results(ingredient)
    v = []
    html_data = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}").read
    nokogiri_object = Nokogiri::HTML(html_data)
    recipes = nokogiri_object.css(".m_titre_resultat > a")
    des = nokogiri_object.css(".m_texte_resultat")
    tim = nokogiri_object.css("div.m_detail_time > div:nth-child(1)")
    dif = get_difficulty(ingredient, nokogiri_object)
    y = assign_recipes_from_results(v, recipes, des, tim, dif)
    return y
  end

  def assign_recipes_from_results(arr, recipes, des, tim, dif)
    recipes[0..4].each_with_index do |r, i|
      arr << Recipe.new(name: r['title'], description: des[i].text.gsub!(/^\s+/, ""), time: tim[i].text, dif: dif[i])
    end
    return arr
  end

  def get_difficulty(ingredient, nokogiri_object)
    all_difficulties = []
    recipes = nokogiri_object.css(".m_detail_recette")
    recipes.each do |x|
      arr = x.text.split("-")
      all_difficulties << arr[2]
    end
    return all_difficulties
  end
end
