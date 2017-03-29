def interactive_menu
  students = []
  loop do
    # 1. show user a list of options
    puts "1. Input new students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. ask the user what to do
    selection = gets.chomp
    # 3. execute user request
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print_all(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try again."
    end
  end
end






def input_students
  puts "ADD STUDENT INFORMATION:"
  puts "Please enter the information for each student."
  puts "To finish, ignore options and hit return. "
  # create an empty array
  students = []
  # get the first name
  name = gets.strip #strip

  puts "\nPlease enter the month"
  month = gets.chomp
  while !name.empty? do

        if !month.empty?
            students << {name: name, cohort: month}
        else
            students << {name: name, cohort: :UNKNOWN}
        end

        if students.count > 1
          puts "\nWe now have #{students.count} students."
        else
          puts "\nWe now have #{students.count} student."
        end
      puts "-" * $lineWidth
      puts "\nPlease enter another name or hit return twice"
      name = gets.chomp
      puts "Enter another month"
      month = gets.chomp
  end
  students
end

#def search_criteria
#end

def print_header
  puts "\nThe Students of Rhubarb Academy".center($lineWidth)
  puts "-" * $lineWidth
end

# captures which letter the user wants to search by
def get_letter
  puts "What letter would you like to search for pupils by?"
  first_letter = gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{first_letter}"
  puts '-' * $lineWidth
  first_letter
end

# Obtain number of characters to search for
def get_char
    puts "Search for names of characters less than:"
    char = gets.chomp.to_i
    puts "The Students of Rhubarb Academy with names shorter than #{char}"
    puts '-' * $lineWidth
    char
  end

# prints all registered student with index position
def print_all(students)
  students.each_with_index do |student, idx|
    puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

# prints all students using a while loop
def print_while(students)
  count = 0
    until count == students.count do
      students.each_with_index do |student, idx|
        puts "#{idx+1}. #{student[:name]}" + "(#{student[:cohort]} cohort)".rjust(40)
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

# Returns students with names under a user determined number of characters
def print_char(students, char)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length < char
  end

end

def print_by_cohort(students)
  cohorts = students.map {|student| student[:cohort]}.uniq
  cohorts.each do |month|
    students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == month
    end
  end
end

# prints total num of students on roll
def print_footer(students)
  puts "-" * $lineWidth
  if students.count > 1
    puts "We have #{students.count} great students in total. "
  elsif students.count == 1
    puts "We have 1 great student. "
  else
    puts "We have zero students in the directory"
  end
end

# Global constants
$lineWidth = 60
$columnWidth = 15
# For automating user input at top
info_keys = [:surname, :forename, :cohort, :DOB, :gender]

# method calls
interactive_menu
#students = input_students
#print_header
#print_all(students)
#print_header
#print_while(students)
#print_with_letter(students, get_letter)
#print_char(students, get_char)
#print_by_cohort(students)
#print_footer(students)
