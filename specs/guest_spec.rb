require('minitest/autorun')
require_relative('../guest')
require_relative('../song')

class GuestTest < MiniTest::Test

  def setup
    @guest1 = Guest.new("Ewa", 10, Song.new("Friday I'm In Love", "The Cure"))
  end

  def test_guest_has_name
    assert_equal("Ewa", @guest1.name)
  end

  def test_guest_has_wallet
    assert_equal(10, @guest1.wallet)
  end

  def test_pay
    assert_equal(7, @guest1.pay(3))
  end

  def test_guest_has_favourite_song
    assert_equal("Friday I'm In Love", @guest1.fav_song.title)
  end

  def test_cheer
    assert_equal("Whoo!", @guest1.cheer())
  end

end
