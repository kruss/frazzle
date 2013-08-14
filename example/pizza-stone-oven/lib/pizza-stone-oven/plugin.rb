
class PizzaStoneOven
  def initialize(options)
    @pizza_type = options[:pizza_type]
  end
  def make_pizza()
    if @pizza_type != nil then
      puts "The pizza-stone-oven is making a #{@pizza_type} pizza"
    else
      puts "The pizza-stone-oven is idle"
    end
  end
end

class PluginLoader
  def create(options = nil)
    return PizzaStoneOven.new(options)
  end
end
PluginLoader.new()

