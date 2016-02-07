require "frazzle/frazzle"

class PizzaFactory

  def initialize()
    puts "This is the pizza factory"
    @registry = Frazzle::Registry.new("pizza")
  end

  def run()
    pizzas = [ "Margerita", "Fungi", "Scampi" ]
    plugins = @registry.plugins("oven")
    plugins.each do |plugin|
      oven = plugin.load.create({ :pizza_type => pizzas.pop })
      oven.make_pizza()
    end
  end

end
