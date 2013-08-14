
class PizzaElectricOven
  def initialize(options)
    @pizza_type = options[:pizza_type]
  end
  def make_pizza()
    if @pizza_type != nil then
      puts "The pizza-electric-oven is making a #{@pizza_type} pizza"
    else
      puts "The pizza-electric-oven is idle"
    end
  end
end

class PluginLoader
  def create(options = nil)
    return PizzaElectricOven.new(options)
  end
end
PluginLoader.new()

