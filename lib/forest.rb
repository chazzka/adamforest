# frozen_string_literal: true

require_relative "ml_forest/version"
require_relative "ml_forest/node"

module Forest
  include Node

  class Tree
    attr_reader :trees, :forest_helper

    def initialize(
      data,
      forest_helper:,
      trees_count: 100
    )
      @forest_helper = forest_helper
      @trees = trees_count.times.map { |x| Node.init_from_data(forest_helper.get_sample(data, x), forest_helper: @forest_helper) }
    end

    def evaluate_forest(element)
      trees.map { |tree| Node.walk_nodes(tree, element, forest_helper: @forest_helper) }
    end
  end
end
