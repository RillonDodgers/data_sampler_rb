# test/test_data_sampler.rb
require 'test/unit'
require_relative '../lib/data_sampler'

class TestDataSampler < Test::Unit::TestCase
  def setup
    @data = [
      { color: "Red", name: "Apple", smell: "Sweet" },
      { color: "Yellow", name: "Banana", smell: "Fruity" },
      { color: "Orange", name: "Orange", smell: "Citrusy" },
      { color: "Green", name: "Lime", smell: "Tart" },
      { color: "Purple", name: "Grapes", smell: "Sweet" },
      { color: "Pink", name: "Dragon Fruit", smell: "Mild" },
      { color: "Blue", name: "Blueberry", smell: "Sweet" },
      { color: "Brown", name: "Kiwi", smell: "Tart" },
      { color: "Black", name: "Blackberry", smell: "Earthy" },
      { color: "White", name: "Coconut", smell: "Sweet" },
      { color: "Red", name: "Cherry", smell: "Sweet" },
      { color: "Red", name: "Strawberries", smell: "Sweet" }
    ]
    @sampler = DataSampler.new(@data)
  end

  def test_sample_by_color
    sampled_data = @sampler.sample_by([:color], 50)
    sampled_colors = sampled_data.map { |hash| hash[:color] }.uniq
    assert_not_empty sampled_data
    assert_includes sampled_colors, "Red"
    assert_includes sampled_colors, "Yellow"
    assert_includes sampled_colors, "Orange"
    assert_includes sampled_colors, "Green"
    assert_includes sampled_colors, "Purple"
    assert_includes sampled_colors, "Pink"
    assert_includes sampled_colors, "Blue"
    assert_includes sampled_colors, "Brown"
    assert_includes sampled_colors, "Black"
    assert_includes sampled_colors, "White"
  end

  def test_sample_by_name
    sampled_data = @sampler.sample_by([:name], 30)
    sampled_names = sampled_data.map { |hash| hash[:name] }
    assert_not_empty sampled_data
    assert_includes sampled_names, "Apple"
    assert_includes sampled_names, "Banana"
    assert_includes sampled_names, "Orange"
    assert_includes sampled_names, "Lime"
    assert_includes sampled_names, "Grapes"
    assert_includes sampled_names, "Dragon Fruit"
    assert_includes sampled_names, "Blueberry"
    assert_includes sampled_names, "Kiwi"
    assert_includes sampled_names, "Blackberry"
    assert_includes sampled_names, "Coconut"
    assert_includes sampled_names, "Cherry"
    assert_includes sampled_names, "Strawberries"
  end

  def test_invalid_percentage
    assert_empty @sampler.sample_by([:color], -10)
    assert_empty @sampler.sample_by([:color], 0)
    assert_empty @sampler.sample_by([:color], 110)
  end

  def test_empty_keys
    assert_empty @sampler.sample_by([], 50)
  end

  def test_sample_by_color_and_smell
    sampled_data = @sampler.sample_by([:color, :smell], 10)
    sampled_combinations = sampled_data.map { |hash| [hash[:color], hash[:smell]] }.uniq

    assert_not_empty sampled_data
    assert sampled_combinations.all? { |comb| @data.any? { |d| d[:color] == comb[0] && d[:smell] == comb[1] } }
  end

  def test_sample_only_color_and_sweet
    red_sweet_data = [
      { color: "Red", name: "Apple", smell: "Sweet" },
      { color: "Red", name: "Cherry", smell: "Sweet" },
      { color: "Red", name: "Strawberries", smell: "Sweet" },
      { color: "Red", name: "Dragon Fruit", smell: "Sweet" },
      { color: "Red", name: "Watermelon", smell: "Sweet" },
      { color: "Black", name: "Blackberry", smell: "Sweet" }
    ]
    sampler = DataSampler.new(red_sweet_data)
    sampled_data = sampler.sample_by([:color, :smell], 20)

    assert_equal 2, sampled_data.size
    assert_equal "Red", sampled_data[0][:color]
    assert_equal "Sweet", sampled_data[0][:smell]
    assert_equal "Black", sampled_data[1][:color]
    assert_equal "Sweet", sampled_data[1][:smell]
  end
end
