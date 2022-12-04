require 'byebug'

def calc_priority(item)
  raise if item.is_a? Numeric
  raise unless item.respond_to?('ord')
  return item.ord - 96 if item > 'Z'

  item.ord - 38
end

sum = 0

# File.open("input_3.txt",'r') do |file|
#   input = file.read
#   arr = input.split("\n")
  
#   arr.each do | pair |
#     arr = pair.split('')
#     mid = arr.length / 2

#     first_rucksack = arr.slice(0, mid)
#     second_rucksack = arr.slice(mid, mid)
#     matches = first_rucksack & second_rucksack
    
#     sum += calc_priority(matches.pop)
#   end

#   puts sum
# end

File.open("input_3.txt",'r') do |file|
  input = file.read
  arr = input.split("\n")
  first = []
  second = []
  third = []

  arr.each do | elf_rucksacks |
    if first.empty?
      first = elf_rucksacks.split('')
      next
    end

    if second.empty?
      second = elf_rucksacks.split('')
      next
    end

    if third.empty?
      third = elf_rucksacks.split('')
    end

    badge = first & second & third
    badge = badge.pop
    sum += calc_priority(badge)
    first = []
    second = []
    third = []
  end

  puts sum
end