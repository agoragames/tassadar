module Tassadar
  module SC2
    class Game
      attr_accessor :map, :time, :winner, :speed, :type, :category

      attr_reader :replay

      def initialize(replay)
        @replay = replay

        @winner = replay.players.select {|p| p.won}.first
        @time = convert_windows_to_ruby_date_time(replay.details.data[5], replay.details.data[6])
        @map = replay.details.data[1]
        @type = replay.attributes.attributes.select {|a| a.id == 2001}.first.attribute_value

        speeds = {"Fasr" => "Faster", "Slow" => "Slow", "Fast" => "Fast", "Norm" => "Normal", "Slor" => "Slower"}
        @speed = speeds[replay.attributes.attributes.select {|a| a.id == 3000}.first.attribute_value]

        categories = {"Amm" => "Ladder", "Priv" => "Private", "Pub" => "Public"}
        @category = categories[replay.attributes.attributes.select {|a| a.id == 3009}.first.attribute_value]
      end

      def winners
        replay.players.select {|player| player.won }
      end

      private
      def convert_windows_to_ruby_date_time(time, zone)
        unix_time = (time - 116444735995904000) / (10 ** 7)

        @time = Time.at(unix_time)
      end
    end
  end
end
