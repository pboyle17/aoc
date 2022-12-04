require 'byebug'

def getSectionArr(string_representation)
  raise if string_representation.split('-').empty?
  first, last = string_representation.split('-')
  [ *first..last]
end

def minArr(arr1, arr2)
  return arr1.length if arr1.length <= arr2.length

  arr2.length
end

# File.open("input_4.txt",'r') do |file|
#   input = file.read
#   arr = input.split("\n")
  
#   sum = 0
#   arr.each do | line |
#     first_elf, second_elf = line.split(',')
#     arr1 = getSectionArr(first_elf)
#     arr2 = getSectionArr(second_elf)
#     union = arr1 & arr2

#     if (union.length == minArr(arr1, arr2))
#       sum += 1
#     end
#   end

#   puts sum
# end

File.open("input_4.txt",'r') do |file|
  input = file.read
  arr = input.split("\n")
  
  sum = 0
  arr.each do | line |
    first_elf, second_elf = line.split(',')
    arr1 = getSectionArr(first_elf)
    arr2 = getSectionArr(second_elf)
    union = arr1 & arr2

    if (union.length > 0)
      sum += 1
    end
  end

  puts sum
end