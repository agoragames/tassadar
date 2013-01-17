# Tassadar

A fast Starcraft 2 replay parser written in pure Ruby... now with JRuby support! See below for performance comparison.

## Tested under..

* ruby-1.9.3-p194
* jruby-1.7.0
* jruby-1.7.2

*Not compatible with jruby-1.6.*

## Installation

Add this line to your application's Gemfile:

```
gem 'tassadar'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install tassadar
```

## Usage

Create a replay object:

```ruby
replay = Tassadar::SC2::Replay.new(path_to_replay)
```

All of the important information is in the game object:

```ruby 
replay.game
=> #<Tassadar::SC2::Game:0x007f9e41e31408 @winner=#<Tassadar::SC2::Player:0x007f9e41e31728 @name="redgar", @id=2569192, @won=true, @color={:alpha=>255, :red=>0, :green=>66, :blue=>255}, @chosen_race="Zerg", @actual_race="Zerg", @handicap=100>, @time=2011-07-05 17:01:08 -0500, @map="Delta Quadrant">
```

Or the player objects:

```ruby
replay.players.first	
=> #<Tassadar::SC2::Player:0x007f9e41e31a48 @name="guitsaru", @id=1918894, @won=false, @color={:alpha=>255, :red=>180, :green=>20, :blue=>30}, @chosen_race="Terran", @actual_race="Terran", @handicap=100>
```

## Benchmarks

### Method

    require 'tassadar'
    require 'benchmark'

    puts Benchmark.measure {
      puts Tassadar::SC2::Replay.new('spec/replays/random.SC2Replay').game.winner.name
    }

### tassadar-0.2 ( ruby-1.9.3-p194 )

    $ ruby ./benchmark.rb 
    PaWeL
      0.040000   0.000000   0.040000 (  0.038560)


### tassadar-0.2 ( jruby-1.7.0 )

    $ ruby ./benchmark.rb 
    PaWeL
      2.330000   0.010000   2.340000 (  0.904000)

### tassadar-0.2 ( jruby-1.7.2 )

    $ ruby ./benchmark.rb 
    PaWeL
      2.110000   0.060000   2.170000 (  0.861000)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2011-2013 Agora Games. See LICENSE.txt for further details.
