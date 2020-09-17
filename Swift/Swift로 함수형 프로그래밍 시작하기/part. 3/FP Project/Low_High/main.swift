import Foundation
 

//let answer = Int(arc4random() % 100) + 1

enum Result: String {
    case wrong = "Wrong"
    case correct = "Correct!"
    case high = "High"
    case low = "Low"
}

func generateAnswer(_ min: Int, _ max: Int) -> Int {
    return Int(arc4random()) % (max - min) + 1
}

func inputAndCheck(_ answer: Int) -> () -> Bool {
    return { printResult(evaluateInput(answer)) }
}

func evaluateInput(_ answer: Int) -> Result {
    guard let userInput = Int(readLine() ?? "") else { return .wrong }
 
    if userInput > answer { return .high }
    if userInput < answer { return .low }
    
    return .correct
}

func printResult(_ r: Result) -> Bool {
    if case .correct = r { return false }
    print(r.rawValue)
    return true
}

let corrected: (Int) -> Void = { i in print("Correct! : \(i)") }



func countingLoop(_ needCouning: @escaping ()->Bool, _ finished: (Int)->Void) {

    func counter(_ c: Int) -> Int {
        if !needCouning() { return c }
        return counter(c + 1)
    }
    
    finished(counter(0))
}

 

countingLoop(inputAndCheck(generateAnswer(1, 100)), corrected)
 
