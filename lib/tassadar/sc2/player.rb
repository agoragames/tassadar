module Tassadar
  module SC2
    class Player
      attr_accessor :name, :id, :won, :color, :chosen_race, :actual_race, :handicap

      def initialize(details_hash, attributes)
        @name = details_hash[0]
        @id = details_hash[1][4]
        @won = [false, true, false][details_hash[8]]
        @color = {:alpha => details_hash[3][0], :red => details_hash[3][1], :green => details_hash[3][2], :blue => details_hash[3][3]}
        races = {"Terr" => "Terran", "Prot" => "Protoss", "Zerg" => "Zerg", "RAND" => "Random"}
        @chosen_race = races[attributes.select {|a| a.id == 0x0BB9 && a.player_number == details_hash[7] + 1}.first.attribute_value]
        @actual_race = details_hash[2]
        @handicap = details_hash[6]
      end

      def winner?
        @won
      end
    end
  end
end
