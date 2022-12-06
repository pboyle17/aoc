require 'byebug'
File.open("input_6.txt",'r') do |file|
  input = file.read

  count = 0
  arr_count = 14
  arr = []

  input.split('', -1).each do | char |
    count += 1
    arr.push(char) unless arr_count <= arr.length
    next if count <= arr_count
    arr.shift
    arr.push(char)
    break if arr.uniq.length == arr_count
  end

  puts count
end