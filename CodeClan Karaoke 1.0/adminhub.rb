require('pry')
class AdminHub
  attr_reader :rooms, :playlists, :guests_in_rooms, :guests_outside_rooms

  def initialize()
    @rooms = []
    @guests_outside_rooms = []
    @guests_in_rooms = []
  end

  def create_room()
    puts "Please enter the new room's name (number)"
    new_room_number = gets.chomp
    new_room_playlist = nil
    puts "Please enter room's capacity"
    new_room_capacity = gets.chomp
    puts "Please enter the room's entry fee"
    new_room_fee = gets.chomp
    @rooms << Room.new(new_room_number, new_room_playlist, new_room_capacity, new_room_fee)
  end

  def find_room(num)
    for room in @rooms
      if room.number == num
        return room
      end
    end
    puts "Room not found. Going back to main menu..."
    sleep(2)
    return
  end

  def find_guest(name, array)
    for guest in array
      if guest.name == name
        return guest
      end
    end
    puts "Guest not found. Going back to main menu..."
    sleep(2)
    return
  end

  def add_new_song_to_room
    if @rooms == []
      puts "There are no rooms on the club's list! Going back to main menu..."
      sleep(2)
      return
    end
    puts "Which room would you like to add the song to?"
    room_num = gets.chomp
    room = find_room(room_num)
    unless room == nil
      puts "Room found! Let's add a song."
      puts "Please enter the song's title:"
      title = gets.chomp
      puts "Please enter the song's artist:"
      artist = gets.chomp
      room.add_song(Song.new(title, artist))
    end
  end

  def create_guest_account()
    puts "Enter the guest's name"
    guests_name = gets.chomp.downcase.capitalize
    puts "Enter the guest's favourite song title"
    song_title = gets.chomp
    puts "Enter the song's artist"
    song_artist = gets.chomp

    @guests_outside_rooms << Guest.new(guests_name, "10", Song.new(song_title, song_artist))
  end

  def check_in_guest()
    if @guests_outside_rooms == []
      puts "There are no guests to check in! Going back to main menu..."
      sleep(2)
      return
    elsif @rooms == []
      puts "There are no available rooms! Going back to main menu..."
      sleep(2)
      return
    end
    puts "The following guests can be checked into a room:"
    for guest in @guests_outside_rooms
      puts guest.name
    end
    puts "Please enter which guest you'd like to check in"
    guest_name = gets.chomp
    guest_to_check_in = find_guest(guest_name, @guests_outside_rooms)
    return if guest_to_check_in == nil
    puts "Here's a list of available rooms"
    for room in @rooms
      puts room.number
    end
    puts "Please select a room number"
    room_no = gets.chomp
    room = find_room(room_no)
    return if room == nil
    room.check_in(guest_to_check_in)
    puts "#{guest_to_check_in.name} has been checked into room no. #{room.number}" if room.occupants.last == guest_to_check_in
    @guests_in_rooms << @guests_outside_rooms.delete(guest_to_check_in)
    sleep(2)
  end

  def check_out_guest()
    if @guests_in_rooms == []
      puts "There are no guests to check out! Going back to main menu..."
      sleep(2)
      return
    elsif @rooms == []
      puts "There are no available rooms! Going back to main menu..."
      sleep(2)
      return
    end
    puts "Here's a list of rooms together with their occupants"
    print_rooms()
    puts "Please specify which room you'd like to check out a guest from"
    room_no = gets.chomp
    room = find_room(room_no)
    return if room == nil
    puts "Please state which guest you'd like to check out"
    guest_name = gets.chomp
    guest_to_check_out = find_guest(guest_name, @guests_in_rooms)
    return if guest_to_check_out == nil
    room.check_out(guest_to_check_out)
    @guests_outside_rooms << @guests_in_rooms.delete(guest_to_check_out)
    if !room.occupants.include?(guest_to_check_out)
      puts "#{guest_name} has been checked out from room #{room_no}"
      sleep(2)
    end
  end

  def print_rooms()
    if @rooms == []
      puts "No rooms to show."
      sleep(2)
      return
    else
      for room in @rooms
        puts "\nRoom #{room.number}, capacity: #{room.capacity}, entry fee: #{room.entry_fee}"
        puts "Current occupants:"
        room.display_occupants()
        puts "Playing:"
        room.display_playlist()
      end
    end
  end

  def print_guests()
    if @guests_outside_rooms == [] && @guests_in_rooms == []
      puts "No guests to show."
      sleep(2)
      return
    else
      unless @guests_outside_rooms.empty?
        for guest in @guests_outside_rooms
          puts "Name: #{guest.name}, favourite song: \"#{guest.fav_song.title}\" by #{guest.fav_song.artist}"
        end
      end
      unless @guests_in_rooms.empty?
        for guest in @guests_in_rooms
          puts "Name: #{guest.name}, favourite song: \"#{guest.fav_song.title}\" by #{guest.fav_song.artist}"
        end
      end
    end
  end

  def view_till
    sum = 0
    for room in @rooms
      sum += room.till
    end
    puts "Money in till: #{sum}"
  end

  def clear_screen()
    puts "\nPress any key to continue."
    STDIN.getch
    system("clear")
  end

end
