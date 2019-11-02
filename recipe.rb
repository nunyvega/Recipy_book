class Recipe
  attr_reader :name, :description, :time, :done, :dif
  def initialize(args = {})
    @name = args[:name]
    @description = args[:description]
    @time = args[:time] || 0
    @done = false
    @dif = args[:dif] || "unknown"
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end



