require 'byebug'

File.open("day2.txt",'r') do |file|
  input = file.read
  lines = input.split("\n")

  count = 0

  lines.each_with_index do | line, index |
    catch :next_outer do
      levels = line.split.map(&:to_i)
      # byebug
      
      prev = nil
      safe = false
      ascending = nil


      levels.each do | current |
        if prev.nil?
          prev = current
          next
        end

       if prev === current
        prev = current
        throw :next_outer
       end

        if ascending.nil?
          ascending = prev < current ? true : false
        end

        if ascending
          if prev > current || current - prev > 3
            prev = current
            throw :next_outer 
          end
        else
          if current > prev || prev - current > 3
            prev = current
            throw :next_outer 
          end
        end
        prev = current
      end
      count += 1
    end
  end
  p count
end