require 'pry-byebug'

class Scanner
  attr_accessor :last_depth, :increased_count

  def initialize
    @last_depth = nil
    @increased_count = 0;
  end

  def has_increased?(depth)
    return false if last_depth.nil?
    return false unless last_depth.sum < depth

    true
  end

  def increment
    self.increased_count = increased_count + 1
  end
end

class Scanner2 < Scanner

  def initialize
    super
    @last_depth = [];
  end

  def has_increased?(depth_sum)
    return false unless last_depth.count == 3
    return false unless last_depth < depth_sum

    true
  end

  def slide_window(depth)
    self.last_depth = self.last_depth.unshift depth
    
    return unless self.last_depth.count < 3

    self.last_depth.pop
  end
end

# File.open("input_1.txt",'r') do |file|
#   input = file.read
#   arr = input.split("\n")

#   increases_count = 0
#   scanner = Scanner.new

#   arr.map(&:to_i).each do |depth|
#     # byebug
#     scanner.increment if scanner.has_increased?(depth)
#     scanner.last_depth = depth
#   end

#   pp scanner.increased_count
# end

File.open("input_1.txt",'r') do |file|
  input = file.read
  arr = input.split("\n")

  increases_count = 0
  scanner = Scanner2.new

  arr.map(&:to_i).each do |depth|
    byebug
    scanner.increment if scanner.has_increased? depth
    scanner.slide_window depth
  end

  pp scanner.increased_count
end