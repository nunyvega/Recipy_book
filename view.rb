class View
  def add_new_recipe
    content = []
    print "what's the name of the recipe? \n>"
    content[0] = gets.chomp
    print "what's the description of the receipt? \n>"
    content[1] = gets.chomp
    print "what's the prep time? \n>"
    content[2] = gets.chomp
    print "How difficult is it? \n>"
    content[3] = gets.chomp
    return content
  end

  def print_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? "[x]" : "[ ]"
      print done.to_s
      puts "#{index + 1}. #{recipe.name} : #{recipe.description}, #{recipe.time}, #{recipe.dif}"
    end
  end

  def remove_recipe
    puts "which recipe number?"
    print ">"
    gets.chomp.to_i - 1
  end

  def ingredient
    puts "What ingredient would you like a recipe for?"
    print ">"
    ingredient = gets.chomp
    puts "Looking for \"#{ingredient}\" on LetsCookFrench..."
    return ingredient
  end

  def give_imported_recipe_options(first_five)
    first_five.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
    puts "Which recipe would you like to import? (enter index)"
    print ">"
    selection = gets.chomp
    puts "Importing \"#{first_five[selection.to_i - 1].name}\"..."
    return selection.to_i - 1
  end

  def mark_done
    puts "which one do you want to mark as done?(use index number)"
    print ">"
    gets.chomp.to_i - 1
  end
end


