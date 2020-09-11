import Foundation

class MinStack {
    var stack: [Int]!
    var minStack: [Int]!
     
    init() {
        stack = [Int]()
        minStack = [Int]()
    }
    
    func push(_ x: Int) {
        stack.append(x)
         
        if minStack.isEmpty {
            minStack.append(x)
        }
        
        if let minValue = minStack.last,
            minValue > x {
            minStack.append(x)
        }
        
    }
     
    func pop() {
        if let value = stack?.removeLast() {
            if let minValue = minStack.last {
                if minValue == value {
                    minStack.removeLast()
                }
            }
        }
    }
    
    func top() -> Int {
        return stack?.last ?? 0
    }
    
    func getMin() -> Int {
        return minStack.last ?? 0
    }
}


