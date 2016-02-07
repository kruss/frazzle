frazzle
=========

Simple plugin-manager facilitating ruby gems.

## Introduction
Lets say we want to implement a pizzaria without hardcoding recipes or
ovens. New recipes or ovens should be picked out automatically as soon
as a fitting gem is installed.

For this we would have to create the following "plugin" gems for the
recipes:

- pizzaria_margerita_recipe
- pizzaria_tonno_recipe
- pizzaria_diavola_recipe

and for the ovens:

- pizzaria_wood_oven
- pizzaria_electric_oven

The pizzaria application could then find all recipes and call them with:

    registry = Frazzle::Registry.new('pizzaria', '_', '_')
    plugins = registry.get_plugins('recipe')
    plugins.each do |plugin|
      registry.load_plugin(plugin, Context.new)
    end

The interesting part is the second argument to load_plugin.
Frazzle executes the file lib/gemname/plugin.rb with instance oval on
this object. You are free to come up with a plugin mechanism you like.

## Conventions
As seens in the intrductionary example, the plugin system has some
conventions hardcoded.

1. The gems that can be used as plugin must follow a nameing scheme:
      `application_plugin_type`. The seapator between application,
      plugin and type can be configured.
2. Frazzle always instance-evals the file lib/gemname/plugin.rb.

## Todo
- returning plugin objects instead of string from the search functions
  of registry.
  
