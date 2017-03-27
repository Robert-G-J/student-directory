#put students into an array
students = [
   ["Dr. Hannibal Lecter", :november],
   ["Darth Vader", :november],
   ["Nurse Ratched", :november],
   ["Michael Corleone", :november],
   ["Alex DeLarge", :november],
   ["The Wicked Witch of the West", :november],
   ["Terminator", :november],
   ["Freddy Krueger", :november],
   ["The Joker", :november],
   ["Joffrey Baratheon", :november],
   ["Norman Bates", :november],
   ["Michael Gove", :november]
 ]

def print_header
  puts "The students of Villains Academy"
  puts "-" * 15
end

def print(students)
  students.each do |student|
    puts "#{student[0]} (#{student[1]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

#nothing will happen unless we call the methods
print_header
print(students)
print_footer(students)
