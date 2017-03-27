#captures student names and inputs to an array of hashes
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

#def search_criteria
#end

def print_header
  puts "The students of Rhubarb Academy"
  puts "-" * 15
end

# captures which letter the user wants to search by
def get_char
  puts "What letter would you like to search for pupils by?"
  first_letter = gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{first_letter}"
  puts '-' * 15
  first_letter
end

# prints all registered student with index position
def print(students)
  students.each_with_index do |student, idx|
    puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

# prints all students using a while loop
def print_while(students)
  count = 0
    until count == students.count do
      students.each_with_index do |student, idx|
        puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
        count += 1
      end
    end
end

# Returns pupils only if they meet the condition in the block, which is the first letter of their name.
def print_with_letter(students, letter)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].start_with?(letter)
  end
end

# prints total num of students on roll
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# method calls
students = input_students
print_header
print(students)
print_header
print_while(students)
print_with_letter(students, get_char)
print_footer(students)
