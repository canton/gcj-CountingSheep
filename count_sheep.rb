#!/user/bin/env ruby

load 'set.rb'

def solve(n)
  if cached_result = @cache[n]
    return cached_result
  end

  n, multiplier = remove_zeros n
  value = n
  set = Set.new
  all_digits(value, set)
  while set.count < 10
    value += n
    all_digits(value, set)
  end

  value *= multiplier
  @cache[n*multiplier] = value
  value
end

def all_digits(value, set)
  while value >= 10
    r = value % 10
    value = value / 10
    set << r
  end
  set << value
end

def remove_zeros(n)
  multiplier = 1
  while n % 100 == 0
    n = n / 10
    multiplier *= 10
  end
  [n, multiplier]
end

@cache = {}

[2, 4, 6].each do |n|
  ans = 90.fdiv(n).ceil * n
  @cache[n] = ans
end

[20, 40, 60].each do |n|
  ans = 900.fdiv(n).ceil * n
  @cache[n] = ans
end

@cache[0] = 'INSOMNIA'

case_count = gets.chomp.to_i
case_count.times do |cc|
  n = gets.chomp.to_i
  STDERR.puts "#{cc+1}: #{Time.now}" if cc % 10 == 9
  ans = solve(n)

  puts "Case ##{cc+1}: #{ans}"
end
