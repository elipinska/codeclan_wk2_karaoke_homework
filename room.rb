class Room
  attr_reader :number, :occupants, :playlist

  def initialize(input_number, input_playlist)
    @number = input_number
    @occupants = []
    @playlist = input_playlist || []
  end

  def add_song(song)
    @playlist << song
  end

  def check_in(guest)
    @occupants << guest
  end

  def check_out(guest)
    @occupants.delete(guest)
  end
end
