#puts source_code = <<'HEREDOC'
# This makes this process a 'quine'- a program that prints its own source count_students
#************************** Required modules ***********************************#
require 'CSV'


#************************** Global constants ***********************************#
@students = [] # an empty array accessible to all methods
@loadfile = ""
@defaultfile = "students.csv"
# Formatting
@lineWidth = 110
@columnWidth = 15
# For automating user input at top
@info_keys = [:surname, :forename, :cohort, :DOB, :gender]
@valid_months = [:Jan, :Feb, :Mar, :Apr, :Jun, :Jul, :Aug, :Sep, :Oct, :Nov, :Dec]


#************************** Menus and  ***********************************#
def print_menu
  puts "1. Input new students"
  puts "2. Show the students"
  puts "3. Save the student-list to student.csv"
  puts "4. Load student-list from students.csv"
  puts "5. Search for students by the first letter of their name"
  puts "6. Search for names by length"
  puts "7. Print students by cohort"
  puts "8. Exit"
end

def interactive_menu
  #load_as_default
  #students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"; input_students
  when "2"; show_students
  when "3"; try_save_students(check_file_exists); feedback("Save")
  when "4"
    try_load_students_menu(check_file_exists)
    feedback("Load")
  when "5"; print_with_letter(get_letter)
  when "6"; print_char(get_char)
  when "7"; draw_separator; print_by_cohort; draw_separator
  when "8"; exit
  else
    puts "I don't know what you meant, try again."
  end
end

def feedback(action)
  puts "#{action} action completed"
end

#def month_valid?
#end
#************************* Formatting *************************************#
# divides text
def draw_separator
  puts "-" * @lineWidth
end

#************************* Utilising Data **********************************#


def populate_student_info_array(name, month)
  @students << {name: name, cohort: month.to_sym}
end


#************************* Data Capture ************************************#
# captures which letter the user wants to search by
def input_students
  puts "Please enter the information for each student."
  puts "To finish, ignore options and hit return. "
    name = STDIN.gets.strip #strip
  puts "Please enter the month"
    month = STDIN.gets.chomp
  #get_user_input
  while !name.empty? do
        !month.empty? ? populate_student_info_array(name, month) : populate_student_info_array(name, :unknown)
        count_students
        draw_separator
        puts "\nPlease enter another name or hit return twice"
        name = STDIN.gets.chomp
        puts "Enter another month"
        month = STDIN.gets.chomp
  end
end

def get_letter
  puts "What letter would you like to search for pupils by?"
    first_letter = STDIN.gets.chomp.upcase
  puts "The Students of Rhubarb Academy with names beginning with #{first_letter}"
  draw_separator
  first_letter
end

# Obtain number of characters to search for
def get_char
    puts "Search for names of characters less than:"
      char = STDIN.gets.chomp.to_i
    puts "The Students of Rhubarb Academy with names shorter than #{char}"
      draw_separator
    return char
  end


#************************** Print to STDOUT methods ************************#
# prints all registered students with index position
def print_header
  puts "\nThe Students of Rhubarb Academy".center(@lineWidth)
  draw_separator
end

def show_students
  unless @students.empty?
    print_header
    print_student_list
  end
    print_footer
end

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

# counts the number of students on roll
def count_students
  @students.count > 1 ? "\nWe now have #{@students.count} students." : "\nWe now have #{@students.count} student."
end

# prints total num of students on roll
def print_footer
  puts "-" * @lineWidth
  if @students.count > 1
    puts "We have #{@students.count} great students in total. "
  elsif @students.count == 1
    puts "We have 1 great student. "
  else
    puts "We have zero students in the directory"
  end
  draw_separator
end

#***************************** File load & save methods *************************#
def try_save_students(filename)
  filename.nil? ? filename = @loadfile : filename #breaks save : # progresses to save
  if File.exists? (filename)
    save_students(filename)
    puts "Saved to file: #{filename}"
  else
    puts "Sorry, file doesn't exist"
    return
  end
end



def save_students(filename = @loadfile)
  # open the file for writing
  File.open(filename, "w") do |file|
  # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
end

def try_load_students_startup
  ARGV.first.nil? ? filename = @defaultfile : filename = ARGV.first
  if File.exists?(filename) # if it exists
    @loadfile = filename
    load_students(@loadfile)
    puts "Loaded #{@students.count} from file: #{filename}"
  else # if it didn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quits program
  end
end

# Will not load file if no filename is provided
def try_load_students_menu (filename)
  return if filename.nil?
  if File.exists?(filename)
    @loadfile = filename
    load_students(@loadfile)
    puts "Loaded #{@students.count} from file: #{filename}"
  else # if it didn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quits program
  end
end

=begin
def load_students(filename = @defaultfile)
  File.open(filename, "r") do |file|
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',') # makes an array from each line, split at each comma. Before the comma goes
    populate_student_info_array(name, cohort.to_sym)
    end
  end
end
=end

def load_students(filename = @defaultfile)
  CSV.foreach(filename, "r") do |row|
    name, cohort = row 
    populate_student_info_array(name, cohort.to_sym)
    end
end



# asks user for file to load from interactive menu
def ask_for_filename(filename)
  puts "Please enter the student directory file you would like to load, or press enter to load the default."
  filename.empty? ? return : filename
end

def check_file_exists
  puts "Please enter the student-directory file, or press enter for default."
  filename = STDIN.gets.chomp
  File.exists?(filename) ? (return filename) : return
end

#************************** Method Calls ***********************************#
try_load_students_startup
interactive_menu



#HEREDOC
