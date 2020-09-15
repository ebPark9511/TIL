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
        
        if let lastVal = minStack.last,
        lastVal >= x {
            minStack.append(x)
        }
    }
     
    func pop() {
        if let lastVal = stack?.removeLast() {
            if stack.isEmpty {
                minStack.removeAll()
                return
            }
            
            if let minLastVal = minStack.last,
                minLastVal == lastVal {
                minStack.removeLast()
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

 
