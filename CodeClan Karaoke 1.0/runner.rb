require_relative('guest')
require_relative('room')
require_relative('song')
require_relative('adminhub')
require('pry')
require 'io/console'

@adminhub = AdminHub.new()
puts "Hello and welcome to our karaoke club's admin hub!"


while true
  puts "\nPlease type the number of the action you'd like to perform:"
  puts "1 Create a new room \n2 Add a new song to an existing room\n3 Create an account for a new guest \n4 Check in a guest to a room \n5 Check out a guest from a room\n6 View all rooms \n7 View all guests\n8 View till balance\nType 'quit' if you wish to exit the program."

  answer = gets.chomp

  case answer
  when "1"
    @adminhub.create_room()
  when "2"
    @adminhub.add_new_song_to_room()
  when "3"
    @adminhub.create_guest_account()
  when "4"
    @adminhub.check_in_guest()
  when "5"
    @adminhub.check_out_guest()
  when "6"
    @adminhub.print_rooms()
    @adminhub.clear_screen()
  when "7"
    @adminhub.print_guests()
    @adminhub.clear_screen()
  when "8"
    @adminhub.view_till()
    @adminhub.clear_screen()
  when "quit"
      exit
  else
      puts "Please select a valid action!"
      sleep(2)
  end
  system("clear")
end
