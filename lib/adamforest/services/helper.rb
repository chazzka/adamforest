# frozen_string_literal: true

module Helper
  SplitPointD = Data.define(:split_point, :dimension)

  def self.forest_count_split_point(data)
    dimension = data[0].length
    random_dimension = rand(0...dimension)
    min, max = data.flat_map { |x| x[random_dimension] }.minmax
    SplitPointD.new(rand(min..max), random_dimension)
  end

  def self.get_node_groups(data)
    data.group_by { |x| element_decision(x, forest_count_split_point(data)) }
  end

  def self.element_decision(element, split_point_d)
    element[split_point_d.dimension] < split_point_d.split_point
  end

  def self.harmonic_number(num)
    Math.log(num) + 0.5772156649
  end

  def self.harmonic_number_approx(num)
    (1...num).map { |x| 1.0 / x }.sum
  end

  def self.evaluate_path_length_c(batch_size)
    return 1 if batch_size == 2
    return 0 if batch_size < 2

    2 * harmonic_number(batch_size - 1) - 2 * (batch_size - 1) / batch_size
  end

  def self.depth_transform(group, depth)
    depth + 1
  end

  def self.get_initial_decision(data)
    sp = forest_count_split_point(data)

    ->(x) { element_decision(x, sp) }
  end

  def self.decide(data, decision)
    decision.call(data)
  end

  def self.end_condition(data, depth, max_depth)
    depth == max_depth || data.length <= 1
  end
end
