class Room
  attr_reader :number, :occupants, :playlist, :capacity, :entry_fee

  def initialize(input_number, input_playlist, input_capacity, input_fee)
    @number = input_number
    @occupants = []
    @playlist = input_playlist || []
    @capacity = input_capacity
    @entry_fee = input_fee
  end

  def add_song(song)
    @playlist << song
  end

  def check_in(guest)
    unless @occupants.length == @capacity
      if guest.wallet >= @entry_fee
        guest.pay(@entry_fee)
        @occupants << guest
        for song in @playlist
          return guest.cheer() if song.title == guest.fav_song.title
        end
        return
      end
      return "Guest can't afford the fee"
    end
    return "This room is full."
  end

  def check_out(guest)
    @occupants.delete(guest)
  end
end
