# Shapeshifter

Shapeshifter is a simple pattern for transforming data from
one format to another.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shapeshifter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shapeshifter

## Usage

#A Simple Shifter

```ruby
class SimpleShifter < Shapeshifter::Shifter
  def shift(target_object)
    # Transform target_object using source_object
    targeting_object # Return the transformed target
  end

  def revert(target_object)
    # Transform target_object using source_object
    targeting_object # Return the transformed target
  end
end
```

A shifter consists of two methods: `shift` and `revert`. Both
follow the same pattern in that the shifter is instantiated with
a source object and each method receives a target object to manipulate
using the data of the source.

#Chaining

The shifter by itself is not particularly interesting, but where it
gets fun is that they can be chained together to break complex
data manipulations down into simple small chunks.


```ruby
shift_chain = SimpleShifter
                .chain(SimpleShifter2)
                .chain(SimpleShifter3)
```

This shift chain can then be easily reused for both shifting 'forward'
and reverting 'backwards'.

```ruby
shift_chain.shift(source_object, target_object)
shift_chain.revert(source_object, target_object)
```

When running a forward shift the shifters will be run in
sequence `SimpleShifter -> SimpleShifter2 -> SimpleShifter3` each
being instantiated with the source object (then available as
an `attr_reader` within the instance) and then being sent the
`shift` message with the target object as an argument. The target object
will therefore change as it passes through the chain allowing you
to have shifters that operate differently based on its contents.

Revert operates in the same fashion except it runs through the
chain in reverse, starting at `SimpleShifter3` and finishing at
`SimpleShifter` calling the revert method on each instance as
it traverses the chain.

#Nesting

One of the nice side effects is that you can nest shifters calls
within other shifters, e.g.

```ruby
class ComplexShifter < Shapeshifter::Shifter
  def shift(target_object)
    sub_object = source_object.sub_object
    partial_target = internal_chain.shift(sub_object, {})
    target_object.merge(partial_target: partial_target)
  end

  def revert(target_object)
    #...
    internal_chain.revert(sub_object, {})
    #...
    target_object
  end

  def internal_chain
    SimpleShifter
      .chain(SimpleShifter2)
      .chain(SimpleShifter3)
  end
end
```

This allows you to build quite complex data manipulations in small
easily testable chunks.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/shapeshifter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
