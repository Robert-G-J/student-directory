def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Rhubarb Academy"
  puts "-" * 15
end

def print(students)
  students.each_with_index do |student, idx|
    puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
# captures which letter the user wants to search by
def print_specific_header
  puts "What letter would you like to search for pupils by?"
  letter = gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{letter}"
  puts '-' * 15
end
#Returns pupils only if they meet the condition in the block, which is the first letter of their name.
def print_specific(students)
  students.each_with_index do |student, idx|
    puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)" if student[:name].start_with?("R", "r")
  end
end

def print_footer(students)
  puts "Overall, we have #{names.count} great students"
end

#nothing will happen unless we call the methods
students = input_students
print_header
print(students)
print_specific_header
print_specific(students)
print_footer(students)
