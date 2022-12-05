require 'byebug'

def parse_stacks(stacks_input)
  stacks = [[],[],[],[],[],[],[],[],[]]
  gap = 4
  
  stacks_input.split("\n").map do |line|
    count = 0
    column = 0

    line.split('').each do | char |
      next if is_digit?(char)
      if count == 0 
        count += 1
        next
      end

      if count == 1
        stacks[column].unshift(char) unless char.strip.empty?

        column += 1
        count += 1
        next
      end

      if count % 4 == 1
        stacks[column].unshift(char) unless char.strip.empty?
        column +=1
      end

      count += 1
    end
  end

  stacks
end

def parse_procedures(procedures_input)
  procedures_input.split("\n").map do |line|
    arr = line.split.select{ |char| is_digit?(char)}
    arr.map(&:to_i)
  end
end

def is_digit?(s)
  code = s.ord
  48 <= code && code <= 57
end

File.open("input_5.txt",'r') do |file|
  input = file.read
  stacks_input, procedures_input = input.split("\n\n");

  stacks = parse_stacks(stacks_input)
  procedures = parse_procedures(procedures_input)
  procedures.each do | procedure |
    count, from, to = procedure
    from -= 1
    to -= 1
    crates = []
    count.times do
      box = stacks[from].pop
      crates.push(box)
    end

    crates.reverse.each do | crate |
      stacks[to].push(crate)
    end
  end

  chars = stacks.map do | stack |
    stack.last
  end

  puts chars.join
end