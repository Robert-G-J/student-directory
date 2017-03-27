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

#print student names
puts "The students of Villains Academy"
puts "-" * 15
students.each do |student|
  puts student
end

#print the number of students
puts "Overall, we have #{students.count} great students"
