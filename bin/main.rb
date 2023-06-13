# frozen_string_literal: true

require "bundler/setup"
require "forest"
require "ml_forest/services/quicksort"
require "ml_forest/services/novelty"
require "ml_forest/services/isolation"

include Forest

puts "main"

input = [[1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [2, 2]]

forest = Tree.new(input, trees_count: 4, forest_helper: Isolation.new)
evaluation = forest.evaluate_forest([2, 2])
p evaluation

# p forest.trees.map(&:to_h)
# If instances return s very close to 1, then they are definitely anomalies,

depths = evaluation.map(&:depth)
p depths
s = Evaluatable.evaluate_anomaly_score_s(depths, input.size)
p s

p "______"
evaluation = forest.evaluate_forest([1, 1])
depths = evaluation.map(&:depth)
p depths
s = Evaluatable.evaluate_anomaly_score_s(depths, input.size)
p s

input = [5, 8, 3, 4, 2, 7]
forest = Tree.new(input, trees_count: 1, forest_helper: QuickSort.new)
p forest.trees.first.to_h
p forest.trees.first.to_a
p forest.evaluate_forest(6)

input = [[1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [2, 2]]
forest = Tree.new(input, trees_count: 4, forest_helper: Novelty.new)
depths = forest.evaluate_forest([1500, 200]).map(&:depth)
p Evaluatable.evaluate_anomaly_score_s(depths, input.size)
