require 'set'

class DataSampler
  def initialize(data)
    @data = data
  end

  def sample_by(keys, percentage)
    return [] if keys.empty? || percentage <= 0 || percentage > 100

    grouped_data = @data.group_by { |hash| keys.map { |key| hash[key] }.join('-') }
    sampled_data = []

    grouped_data.each_value do |group|
      sample_size = (group.size * (percentage / 100.0)).ceil
      sampled_data.concat(group.sample(sample_size))
    end

    sampled_data
  end
end

