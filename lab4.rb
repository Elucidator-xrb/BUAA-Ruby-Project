def decode_ways(code)
    return 0 if code == 0
    return 1 if code < 10    
    
    s = code.to_s
    dp = Array.new(5001, 0)
    dp[0] = dp[1] = 1
    for i in (2..s.length)
        dp[i] += dp[i-1] if s[i-1] != '0'
        dp[i] += dp[i-2] if s[i-2] != '0' && (1..26) === s[i-2..i-1].to_i
        return 0 if dp[i] == 0
    end
    return dp[i]
end