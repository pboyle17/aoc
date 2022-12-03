require 'pry-byebug'

def opp_shape(opp_code)
    return 'Rock' if opp_code == 'A'
    return 'Paper' if opp_code == 'B'
    
    'Scissors'
end

def result_needed(result_code)
    return 'Loss' if result_code == 'X'
    return 'Tie' if result_code == 'Y'
    
    'Win'
end

def result_score(result_needed)
    return 0 if result_needed == 'Loss'
    return 3 if result_needed == 'Tie'

    6
end

def shape_score(shape)
    return 1 if shape == 'Rock'
    return 2 if shape == 'Paper'

    return 3
end

def my_shape(opp_shape, result_needed)
    return losingShape(opp_shape) if result_needed == 'Loss'
    return tyingShape(opp_shape) if result_needed == 'Tie'

    winningShape(opp_shape)
end

def losingShape(opp_shape)
    return 'Rock' if opp_shape == 'Paper'
    return 'Paper' if opp_shape == 'Scissors'

    'Scissors'
end

def tyingShape(opp_shape)
    return 'Rock' if opp_shape == 'Rock'
    return 'Paper' if opp_shape == 'Paper'

    'Scissors'
end

def winningShape(opp_shape)
    return 'Rock' if opp_shape == 'Scissors'
    return 'Paper' if opp_shape == 'Rock'

    'Scissors'
end

File.open("input-2.txt",'r') do |file|
    input = file.read
    arr = input.split("\n")

    score = 0
    arr.each do | game |
        # byebug
        opp_shape_code, result_code = game.split(' ')
        opp_shape = opp_shape(opp_shape_code)
        result_needed = result_needed(result_code)
        my_shape = my_shape(opp_shape, result_needed)

        score += result_score(result_needed) + shape_score(my_shape)
    end
    puts score
end

