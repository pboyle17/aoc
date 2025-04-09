require 'byebug'
# Part 1
# File.open("day1.txt",'r') do |file|

#   input = file.read
#   arr = input.split("\n")
  
#   diff = 0
#   arr1 = []
#   arr2 = []

#   arr.each do | line |
#     items = line.split("   ")

#     arr2.push(items.pop().to_i)
#     arr1.push(items.pop().to_i)
#   end

#   arr1 = arr1.sort() 
#   arr2 = arr2.sort()

#   arr1.each_with_index do | item, index |
#     distance = item - arr2[index]
#     diff += distance.abs
#   end

#   p diff
# end

# Your analysis only confirmed what everyone feared: the two lists of location IDs are indeed very different.
# Or are they?
# The Historians can't agree on which group made the mistakes or how to read most of the Chief's handwriting, but in the 
# commotion you notice an interesting detail: a lot of location IDs appear in both lists! Maybe the other numbers aren't location IDs at all but rather misinterpreted handwriting.

# This time, you'll need to figure out exactly how often each number from the left list appears in the right list. 
# Calculate a total similarity score by adding up each number in the left list after multiplying it by the number of times that number appears in the right list.
File.open("day1.txt",'r') do |file|

  input = file.read
  lines = input.split("\n")
  
  sum = 0
  arr1 = []
  arr2 = []

  lines.each do | line |
    items = line.split("   ")

    arr2.push(items.pop().to_i)
    arr1.push(items.pop().to_i)
  end

  arr1.each do | value |
    times = arr2.select { |i| i === value}.count

    sum += times * value
  end

  byebug
end