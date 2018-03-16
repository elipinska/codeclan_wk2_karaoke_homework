require('minitest/autorun')
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class RoomTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Ewa")
    @new_song = Song.new("Sweet Caroline", "Neil Diamond")
    @songs_for_room_1 = [Song.new("Help!", "The Beatles"), Song.new("Friday I'm In Love", "The Cure"), Song.new("Private Eyes", "Hall & Oates"), Song.new("Livin' on a Prayer", "Bon Jovi")]
    @room1 = Room.new("1", @songs_for_room_1)
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

end
