class Guest
  attr_reader :name, :wallet, :fav_song

  def initialize(input_name, input_wallet, input_fav_song)
    @name = input_name
    @wallet = input_wallet
    @fav_song = input_fav_song
  end

  def pay(amount)
    @wallet -= amount
  end

  def cheer()
    return "Whoo!"
  end

end
