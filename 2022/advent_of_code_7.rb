require 'byebug'

class String
  def numeric?
    Float(self) != nil rescue false
  end 
end

def parse_command(command)
  return parse_directory_or_file(command) unless command.include?('$')
  return 'list' if command.include?('ls')
  return 'up one directory' if command.split()[1] == 'cd' && command.split.last == '..'
  return 'change directory' if command.split()[1] == 'cd'

  raise
end

def parse_directory_or_file(command)
  return 'directory' if command.split.first == 'dir'
  return 'file' if command.split.first.numeric?
  raise
end

def insert_file(file_name, size, file_system, pwd)
  keys = pwd.split(':')
  case keys.length
  when 1
    key = keys[0]

    file_system[key][file_name] = size.to_i
  when 2
    key1 = keys[0]
    key2 = keys[1]

    file_system[key1][key2][file_name] = size.to_i
  when 3
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2]
    file_system[key1][key2][key3][file_name] = size.to_i
  when 4
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2]
    key4 = keys[3]
    file_system[key1][key2][key3][key4][file_name] = size.to_i
  when 5
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2]
    key4 = keys[3]
    key5 = keys[4]
    file_system[key1][key2][key3][key4][key5][file_name] = size.to_i
  else
  end
end

def insert_directory(new_directory_name, file_system, pwd)
  keys = pwd.split(':')

  case keys.length
  when 1
    key = keys[0]

    file_system[key][new_directory_name] = {} if file_system.dig(key, new_directory_name).nil?
  when 2
    key1 = keys[0]
    key2 = keys[1]
    file_system[key1][key2][new_directory_name] = {} if file_system.dig(key1, key2, new_directory_name).nil?
  when 3
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2]
    file_system[key1][key2][key3][new_directory_name] = {} if file_system.dig(key1, key2, key3, new_directory_name).nil?
  when 4
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2] 
    key4 = keys[3]
    file_system[key1][key2][key3][key4][new_directory_name] = {} if file_system.dig(key1, key2, key3, key4, new_directory_name).nil?
  when 5
    key1 = keys[0]
    key2 = keys[1]
    key3 = keys[2]
    key4 = keys[3]
    key5 = keys[4]
    file_system[key1][key2][key3][key4][key5][new_directory_name] = {} if file_system.dig(key1, key2, key3, key4, key5, new_directory_name).nil?
  else
  end
end

def get_directories(pwd)
  arr = pwd.split(':')
  return arr if arr.length == 1

  directories = []
  arr.length.times do |index|
    directories << arr[0..index].join(':')
  end
  directories
end

def add_file_size(file, size, directory_sizes_hash, pwd)
  directories = get_directories(pwd)
  # byebug if directories.length > 4
  directories.each do | current_directory |
      directory_sizes_hash[current_directory] = { :files => [], :sizes => []} if directory_sizes_hash.dig(current_directory).nil?
      next if directory_sizes_hash[current_directory][:files].include?(file)
      
      directory_sizes_hash[current_directory][:files] << file 
      directory_sizes_hash[current_directory][:sizes] << size.to_i
  end
end

def sum_of_directories_100000_or_less(directory_sizes_hash, fs)
  sums = {}
  sum_of_directories_100000_or_less = 0

  directory_sizes_hash.each do | name, data |
    sums[name] = data[:sizes].sum
  end
  
  filtered = sums.select{ |directory, sum| sum <= 100000}
  sum = filtered.sum {|directory, sum| sum}
  byebug
end

File.open("input_7.txt",'r') do |file|
  input = file.read
  lines = input.split("\n")

  fs = {'root'=>{}}
  pwd = 'root'
  lines.shift
  directory_sizes = {}

  lines.each do | command |
    case parse_command(command)
    when 'directory'
    when 'list'
      next
    when 'change directory'    
      new_directory = command.split(' ').last
      insert_directory(new_directory, fs, pwd)
      pwd = "#{pwd}:#{new_directory}"
    when 'up one directory'
      pwd = pwd.split(':')[0...-1].join(':') unless pwd.split(':').length == 1
    when 'file'
      size, file = command.split(' ')
      insert_file(file, size, fs, pwd)
      add_file_size(file, size, directory_sizes, pwd)
    end
  end

  puts sum_of_directories_100000_or_less(directory_sizes, fs)
end