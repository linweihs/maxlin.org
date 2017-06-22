---
title: Longest valid Parentheses [Hard]
layout: post
class: post
tags: interview hard leetcode
category: code
comments: true
---
## Longest valid Parentheses
Given a string containing just the characters ```'('``` and ```')'```, find the length of the longest valid (well-formed) parentheses substring.

For ```"(()"```, the longest valid parentheses substring is ```"()"```, which has ```length = 2```.

Another example is ```")()())"```, where the longest valid parentheses substring is ```"()()"```, which has ```length = 4```.

## Thoughts
Initially I was thinking O(n) solution using loop and stack, but turns out the dp way is much easier for me to understand. 
The question can be solved by dp, and if you understand it, the algorith is easy to grasp. 

## Solution
```java
public class Solution {
    public int longestValidParentheses(String s) {
        
        if(s == null || s.length() == 0)
            return 0;
        
        int n = s.length();
        
        int[] dp = new int[n];
        dp[0] = 0;
        
        int ans = 0;
        
        for(int i = 0; i + 1 < n; i++){
            
            char c = s.charAt(i+1);
            if(c == '('){
                dp[i+1] = 0;
                continue;
            }
            // c == ')'
            
            // i - dp[i] => matched '('
            if(i - dp[i] >= 0 && s.charAt(i-dp[i]) == '('){
                dp[i+1] = dp[i] + 2;
                
                // i - dp[i] -1 => see if its longest
                if(i - dp[i] - 1 >= 0){
                    dp[i+1] += dp[i -dp[i] - 1];
                }
            }
            if(dp[i+1] > ans) ans = dp[i+1];
        }
        return ans;
    }
}
```
