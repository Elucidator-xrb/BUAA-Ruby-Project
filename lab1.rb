require 'prime'
def mfp(m)
    return m == 1 ? 1 : (1..m).map{|x| x.to_s.gsub('0', '').split('').map{|s| s.to_i}.inject(:*)}.inject(:+).prime_division.map(&:first).max
end
