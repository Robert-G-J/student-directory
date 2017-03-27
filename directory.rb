#put students into an array
students = [
   "Dr. Hannibal Lecter",
   "Darth Vader",
   "Nurse Ratched",
   "Michael Corleone",
   "Alex DeLarge",
   "The Wicked Witch of the West",
   "Terminator",
   "Freddy Krueger",
   "The Joker",
   "Joffrey Baratheon",
   "Norman Bates",
   "Michael Gove",
 ]

def print_header
  puts "The students of Villains Academy"
  puts "-" * 15
end

def print_names(names)
  names.each do |name|
    puts name
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing will happen unless we call the methods
print_header
print(students)
print_footer(students)
