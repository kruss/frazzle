module Frazzle

# ******************************************************************************************************
# Plugin registry maintaining the plugins of a gem.
# ******************************************************************************************************
# A plugin must have a name according convention:
#
# |plugin-gem-name| = |target-name|plugin-entity|plugin-type|
#                                 |--- plugin-name ---------|
#
# Eg: "pizza-stone-oven" and "pizza-electric-oven" could be two "oven" plugins for a "pizza" gem
#
# A plugin must also have a certain layout with a plugin-file in it's installation folder:
#
# [plugin-gem-home]/lib/[plugin-gem-name]/plugin.rb
#
# Where plugin.rb will provide a plugin-loader to create the plugin's runtime object
# ******************************************************************************************************
class Registry

  class Plugin
    attr_reader :name
    def initialize(registry, name)
      @registry = registry
      @name = name
    end
    def load(context=Object.new)
      @registry.load_plugin(@name, context)
    end
  end

  def initialize(base_name, base_separator='-', plugin_separator='-')
    @base_name = base_name
    @base_separator = base_separator
    @plugin_separator = plugin_separator
  end
  attr_accessor :base_name

  def plugins(plugin_type)
    get_plugins(plugin_type).map{|name|Plugin.new(self, name)}
  end

  def get_plugins(plugin_type)
    get_names(get_plugin_gems(plugin_type))
  end


  def all_plugin
    get_all_plugins.map{|name|Plugin.new(self, name)}
  end

  def get_all_plugins
    get_names(find_gems do |spec|
      spec.name =~ /#{@base_name}#{@base_separator}.*/
    end)
  end

  def load_plugin(plugin_name, context=Object.new)
    gem = get_plugin_gem(plugin_name)
    if gem then
      load_plugin_gem(gem, context)
    else
      raise "Unable to find plugin: #{@base_name}#{@base_separator}#{plugin_name}"
    end
  end

private

  def get_names(specs)
    specs.map do |spec|
      spec.name =~ /#{@base_name}#{@base_separator}(.*)/
      $1
    end
  end

  def find_gems(&block)
    Gem::Specification.latest_specs.select do |spec|
      block.call(spec)
    end
  end

  def get_plugin_gems(plugin_type)
    find_gems do |gem|
      gem.name =~ /#{@base_name}#{@base_separator}.*#{@plugin_separator}#{plugin_type}/
    end
  end

  def get_plugin_gem(plugin_name)
    find_gems do |gem|
      gem.name =~ /#{@base_name}#{@base_separator}#{plugin_name}/
    end.first
  end

  def load_plugin_gem(gem, context)
    file = File.join(gem.full_gem_path, 'lib', gem.name, 'plugin.rb')
    if File.exists?(file) then
      content = File.read(file)
      return context.instance_eval(content)
    else
      raise "Unable to load plugin-file: #{file}"
    end
  end
end
end
