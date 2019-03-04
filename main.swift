import Foundation

enum Action {
    
    case INSERT
    case DELETE
    case SUBSTITUTE
}

struct Pair: Comparable {
    let str: String
    let action: Action
    
    init(str: String, action: Action) {
        self.str = str
        self.action = action
    }
    
    static func < (lhs: Pair, rhs: Pair) -> Bool {
        
        return lhs.str.count < rhs.str.count
    }
    
    static func == (lhs: Pair, rhs: Pair) -> Bool {
        
        return lhs.str.count == rhs.str.count
    }
}

func levenshteinDistance( str1: String, str2: String ) -> String {
    
    let len1 = str1.count
    
    let len2 = str2.count
    
    var dp = Array(repeating: Array(repeating: String(), count: len2 + 1), count: len1 + 1)
    
    for i in 0 ... len1 {
        
        for j in 0 ... len2 {
            
            if i == 0 {
                
                if j != 0 {
                    for _ in 1 ... j {
                        dp[i][j].append("i")
                    }
                }
            }
            else if j == 0 {
                
                for _ in 1 ... i {
                    dp[i][j].append("d")
                }
            }
            else if str1[str1.index(str1.startIndex, offsetBy: i - 1)] ==
                    str2[str2.index(str2.startIndex, offsetBy: j - 1)] {
                
                dp[i][j] = dp[i-1][j-1]
            }
            else {
                
                let min_edit = min( Pair(str: dp[i][j-1], action: Action.INSERT),
                                    Pair(str: dp[i-1][j], action: Action.DELETE),
                                    Pair(str: dp[i-1][j-1], action: Action.SUBSTITUTE) )
                
                dp[i][j] = min_edit.str
                
                switch min_edit.action {
                    
                case .INSERT:
                    dp[i][j].append("i")
                case .DELETE:
                    dp[i][j].append("d")
                case .SUBSTITUTE:
                    dp[i][j].append("s")
                }
            }
        }
    }
    
    return dp[len1][len2]
}
