require('minitest/autorun')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class RoomTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Ewa", 10, Song.new("Friday I'm In Love", "The Cure"))
    @new_song = Song.new("Sweet Caroline", "Neil Diamond")
    @songs_for_room_1 = [Song.new("Help!", "The Beatles"), Song.new("Friday I'm In Love", "The Cure"), Song.new("Private Eyes", "Hall & Oates"), Song.new("Livin' on a Prayer", "Bon Jovi")]
    @room1 = Room.new("1", @songs_for_room_1, 5, 3)
  end

  def test_room_has_number
    assert_equal("1", @room1.number)
  end

  def test_room_has_playlist
    assert_equal(@songs_for_room_1, @room1.playlist)
    assert_equal(4, @room1.playlist.length)
  end

  def test_room_has_empty_array_of_occupants
    assert_equal(0, @room1.occupants.length)
  end

  def test_room_has_capacity_of_5
    assert_equal(5, @room1.capacity)
  end

  def test_till
    assert_equal(0, @room1.till)
  end

  def test_add_song
    @room1.add_song(@new_song)
    assert_equal(5, @room1.playlist.length)
    assert_equal("Sweet Caroline", @room1.playlist.last.title)
  end

  def test_check_in
    @room1.check_in(@guest1)
    assert_equal(1, @room1.occupants.length)
    assert_equal("Ewa", @room1.occupants.last.name)
  end

  def test_check_out
    @room1.check_in(@guest1)
    assert_equal(@guest1, @room1.check_out(@guest1))
    assert_equal(0, @room1.occupants.length)
  end

  def test_check_in__full_room
    multiple_guests = [Guest.new("John", 5, Song.new("Nothing Else Matters", "Metallica")), Guest.new("Adam", 8, Song.new("Bohemian Rhapsody", "Queen")), Guest.new("Anna", 10, Song.new("Space Oddity", "David Bowie")), Guest.new("Kate", 7, Song.new("Faith", "George Michael")), Guest.new("Patrick", 6, Song.new("Sweet Home Alabama", "Lynyrd Skynyrd"))]
    for guest in multiple_guests
      @room1.check_in(guest)
    end
    assert_equal("This room is full.", @room1.check_in(@guest1))
  end

  def test_check_in__charge_guest_for_entry
    @room1.check_in(@guest1)
    assert_equal(7, @guest1.wallet)
  end

  def test_check_in__guest_cannot_afford_fee
    skint_guest = Guest.new("Dan", 2, Song.new("Don't You Want Me", "Human League"))
    assert_equal("Guest can't afford the fee", @room1.check_in(skint_guest))
  end

  def test_check_in__guest_cheers
    assert_equal("Whoo!", @room1.check_in(@guest1))
  end

  def test_check_in__money_goes_into_till
    @room1.check_in(@guest1)
    assert_equal(3, @room1.till)
  end

end
