# DataSampler

`DataSampler` is a simple Ruby gem for sampling data from an array of hashes based on specified keys and a sampling percentage.

## Usage

```ruby
require 'data_sampler'

data = [
  { color: "Red", name: "Apple", smell: "Sweet" },
  { color: "Yellow", name: "Banana", smell: "Fruity" },
  { color: "Orange", name: "Orange", smell: "Citrusy" },
  # more data here...
]

sampler = DataSampler.new(data)
```

## Sampling Data
Use the `sample_by` method to sample data based on specified keys and a sampling percentage:

```ruby
sampled_data = sampler.sample_by([:color], 50)  # Sample by color with 50% sampling rate
puts sampled_data.inspect
```

## Example
The result should be two items in the sample, one of the red fruits and the blackberry

```ruby
require 'data_sampler'

data = [
  { color: "Red", name: "Apple", smell: "Sweet" },
  { color: "Red", name: "Cherry", smell: "Sweet" },
  { color: "Red", name: "Strawberries", smell: "Sweet" },
  { color: "Red", name: "Dragon Fruit", smell: "Sweet" },
  { color: "Red", name: "Watermelon", smell: "Sweet" },
  { color: "Black", name: "Blackberry", smell: "Earthy" }  # This should not be sampled
]

sampler = DataSampler.new(data)
sampled_data = sampler.sample_by([:color, :smell], 20)  # 20% sampling rate

puts sampled_data.inspect
```
