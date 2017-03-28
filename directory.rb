def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp

  puts "Please enter the month"
  month = gets.chomp
  while !name.empty? do

        if !month.empty?
            students << {name: name, cohort: month}
        else
              students << {name: name, cohort: :UNKNOWN}
        end

        if students.count > 1
          puts "Now we have #{students.count} students."
        else
          puts "Now we have #{students.count} student."
        end

      puts "Please enter another name or hit return twice"
      name = gets.chomp
      puts "Enter another month"
      month = gets.chomp
  end
  students
end

#def search_criteria
#end

def print_header
  line_width = 60
  puts "\nThe Students of Rhubarb Academy".center(line_width)
  puts "-" * line_width
end

# captures which letter the user wants to search by
def get_letter
  puts "What letter would you like to search for pupils by?"
  first_letter = gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{first_letter}"
  puts '-' * 15
  first_letter
end

# Obtain number of characters to search for
def get_char
    puts "Search for names of characters less than:"
    char = gets.chomp.to_i
    puts "The Students of Rhubarb Academy with names shorter than #{char}"
    puts '-' * 15
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
  puts "Overall, we have #{students.count} great students"
end

# method calls
students = input_students
print_header
print_all(students)
print_header
#print_while(students)
#print_with_letter(students, get_letter)
#print_char(students, get_char)
print_by_cohort(students)
print_footer(students)
