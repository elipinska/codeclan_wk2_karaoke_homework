require('minitest/autorun')
require_relative('../song')

class SongTest < MiniTest::Test

  def setup
    @song1 = Song.new("Karma Chameleon", "Culture Club")
  end

  def test_song_has_title
    assert_equal("Karma Chameleon", @song1.title)
  end

  def test_song_has_artist
    assert_equal("Culture Club", @song1.artist)
  end


end
