@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input new students"
  puts "2. Show the students"
  puts "3. Save the student-list to student.csv"
  puts "4. Load student-list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  #students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again."
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def input_students
  puts "Please enter the information for each student."
  puts "To finish, ignore options and hit return. "
  # get the first name
  name = STDIN.gets.strip #strip
  puts "Please enter the month"
  month = STDIN.gets.chomp
  while !name.empty? do

        if !month.empty?
            populate_student_info_array(name, month)
        else
            populate_student_info_array(name, :unknown)
        end

        if @students.count > 1
          puts "\nWe now have #{@students.count} students."
        else
          puts "\nWe now have #{@students.count} student."
        end
      puts "-" * $lineWidth
      puts "\nPlease enter another name or hit return twice"
      name = STDIN.gets.chomp
      puts "Enter another month"
      month = STDIN.gets.chomp
  end
end

def populate_student_info_array(name, month)
  @students << {name: name, cohort: month.to_sym}
end

def print_header
  puts "\nThe Students of Rhubarb Academy".center($lineWidth)
  puts "-" * $lineWidth
end

# captures which letter the user wants to search by
def get_letter
  puts "What letter would you like to search for pupils by?"
  first_letter = STDIN.gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{first_letter}"
  puts '-' * $lineWidth
  first_letter
end

# Obtain number of characters to search for
def get_char
    puts "Search for names of characters less than:"
    char = STDIN.gets.chomp.to_i
    puts "The Students of Rhubarb Academy with names shorter than #{char}"
    puts '-' * $lineWidth
    char
  end

# prints all registered student with index position
def print_student_list
  @students.each_with_index do |student, idx|
    puts "#{idx+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

# prints all students using a while loop
def print_while
  count = 0
    until count == @students.count do
      @students.each_with_index do |student, idx|
        puts "#{idx+1}. #{student[:name]}" + "(#{student[:cohort]} cohort)".rjust(40)
        count += 1
      end
    end
end

# Returns pupils only if they meet the condition in the block, which is the first letter of their name.
def print_with_letter(letter)
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].start_with?(letter)
  end
end

# Returns students with names under a user determined number of characters
def print_char(char)
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:name].length < char
  end

end

def print_by_cohort
  cohorts = @students.map {|student| student[:cohort]}.uniq
  cohorts.each do |month|
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)" if student[:cohort] == month
    end
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the commandline
  return if filename.nil? # get out of method if not given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from file: #{filename}"
  else # if it didn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quits program
  end
end


def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',') # makes an array from each line, split at each comma. Before the comma goes
    populate_student_info_array(name, cohort.to_sym)
    end
  file.close
end

# prints total num of students on roll
def print_footer
  puts "-" * $lineWidth
  if @students.count > 1
    puts "We have #{@students.count} great students in total. "
  elsif @students.count == 1
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
try_load_students
interactive_menu

#print_header
#print_all(@students)
#print_header
#print_while(@students)
#print_with_letter(@students, get_letter)
#print_char(@students, get_char)
#print_by_cohort(@students)
#print_footer(@students)
