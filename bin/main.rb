# frozen_string_literal: true

require "bundler/setup"
require "adamforest"
require "adamforest/services/helper"

module Main
  include AdamForest
  include HelperContainer.new(Helper)
  puts "main"

  forest = Forest.new([[1, 1], [2, 2], [3, 3], [7, 1000]], trees_count: 1000)
  p([[2.5, 1.5], [2, 100], [7, 50]].map do |x|
    r = forest.evaluate_forest(x)
    r.sum / r.count.to_f
  end)

  evaluation = forest.evaluate_forest([2.5, 1.5])
  p evaluation
end
