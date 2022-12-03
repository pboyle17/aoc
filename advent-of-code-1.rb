require "pry-byebug"

top_three = [] 

File.open("input-1.txt",'r') do |file|
    input = file.read
    arr = input.split("\n\n")
    arr.each do | elf |
        total = elf.split("\n").map(&:to_i).sum

        if top_three.count < 3
            top_three.push(total)
        elsif top_three.any? { |sum| total > sum }
            value, index = top_three.each_with_index.min
            top_three[index] = total
        end
    end
end

pp top_three.sum
