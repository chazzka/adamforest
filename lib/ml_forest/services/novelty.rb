# frozen_string_literal: true

require_relative "isolation/evaluatable"

class Novelty
  include Evaluatable

  SplitPointD = Data.define(:split_point, :dimension)
  DataPoint = Data.define(:depth, :data, :ranges)

  def initialize(batch_size: 128, max_depth: Math.log(batch_size, 2), random: Random.new)
    @batch_size = batch_size
    @max_depth = max_depth
    @random = random
  end

  def get_sample(data, _ = 0)
    ranges = (1..data[0].length).map { |_| (0..3000) }
    DataPoint.new(depth: 0, data: data.sample(@batch_size, random: @random), ranges: ranges)
  end

  def split_point(data_point)
    dimension = data_point.data[0].length
    random_dimension = @random.rand(0...dimension)
    split_range_dimension = data_point.ranges[random_dimension]
    SplitPointD.new(@random.rand(split_range_dimension), random_dimension)
  end

  def decision_function(split_point_d)
    ->(x) { x[split_point_d.dimension] < split_point_d.split_point }
  end

  def decision(element, split_point_d)
    decision_function(split_point_d).call(element)
  end

  def split_ranges(ranges, dimension, split_point)
    new_rangers = ranges.clone
    new_rangers[dimension] = ranges[dimension].min...split_point

    new_rangers2 = ranges.clone
    new_rangers2[dimension] = split_point..ranges[dimension].max

    [new_rangers, new_rangers2]
  end

  def group(data_point, split_point_d)
    s = { true => [], false => [] }.merge(data_point.data.group_by(&decision_function(split_point_d)))

    new_ranges, new_ranges2 = split_ranges(data_point.ranges, split_point_d.dimension, split_point_d.split_point)

    return {
      true => DataPoint.new(depth: data_point.depth + 1, data: s[true], ranges: new_ranges),
      false => DataPoint.new(depth: data_point.depth + 1, data: s[false], ranges: new_ranges2),
    }
  end

  def end_condition(data_point)
    data_point.depth == @max_depth || data_point.data.length <= 1
  end
end
