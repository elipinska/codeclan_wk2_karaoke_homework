class Guest
  attr_reader :name, :wallet, :fav_song

  def initialize(input_name, input_wallet, input_fav_song)
    @name = input_name
    @wallet = input_wallet.to_i
    @fav_song = input_fav_song
  end

  def pay(amount)
    @wallet -= amount
  end

  def cheer()
    puts "Whoo! #{name} loves one of the songs from the playlist!"
  end

end
