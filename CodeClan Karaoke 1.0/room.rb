class Room
  attr_reader :number, :occupants, :playlist, :capacity, :entry_fee, :till

  def initialize(input_number, input_playlist, input_capacity, input_fee)
    @number = input_number
    @occupants = []
    @playlist = input_playlist || []
    @capacity = input_capacity.to_i
    @entry_fee = input_fee.to_i
    @till = 0
  end

  def add_song(song)
    @playlist << song
  end

  def check_in(guest)
    unless @occupants.length == @capacity
      if guest.wallet >= @entry_fee
        guest.pay(@entry_fee)
        @till += @entry_fee
        @occupants << guest
        for song in @playlist
          return guest.cheer() if song.title == guest.fav_song.title
        end
        return
      end
      puts "Guest can't afford the fee"
      sleep(2)
      return
    end
    puts "This room is full."
    sleep(2)
    return
  end

  def check_out(guest)
    if @occupants.include?(guest)
      @occupants.delete(guest)
    else
      puts "No such guest in this room!"
      return
    end
  end

  def display_playlist()
    @playlist.each {|s| puts "#{s.title} by #{s.artist}"}
  end

  def display_occupants()
    @occupants.each {|o| puts "#{o.name}"}
  end
end
