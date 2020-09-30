import Foundation
 

//let answer = Int(arc4random() % 100) + 1
//
//enum Result: String {
//    case wrong = "Wrong"
//    case correct = "Correct!"
//    case high = "High"
//    case low = "Low"
//}
//
//func generateAnswer(_ min: Int, _ max: Int) -> Int {
//    return Int(arc4random()) % (max - min) + 1
//}
//
//func inputAndCheck(_ answer: Int) -> () -> Bool {
//    return { printResult(evaluateInput(answer)) }
//}
//
//func evaluateInput(_ answer: Int) -> Result {
//    guard let userInput = Int(readLine() ?? "") else { return .wrong }
//
//    if userInput > answer { return .high }
//    if userInput < answer { return .low }
//
//    return .correct
//}
//
//func printResult(_ r: Result) -> Bool {
//    if case .correct = r { return false }
//    print(r.rawValue)
//    return true
//}
//
//let corrected: (Int) -> Void = { i in print("Correct! : \(i)") }
//
//
//
//func countingLoop(_ needCouning: @escaping ()->Bool, _ finished: (Int)->Void) {
//
//    func counter(_ c: Int) -> Int {
//        if !needCouning() { return c }
//        return counter(c + 1)
//    }
//
//    finished(counter(0))
//}
//
//
//
//countingLoop(inputAndCheck(generateAnswer(1, 100)), corrected)
//



// 복습
//let answer = Int(arc4random() % 100) + 1
//var count = 0



//// 루프 돌려 count를 증가함
//while true {
//
//    // 텍스트를 받아 올바른 문자열인지 체크
//    let userInput = readLine()
//    guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//        print("Wrong")
//        continue
//    }
//
//    // 받아온 숫자를 비교
//    if inputNumber == answer {
//
//       // 맞았을경우 결과 프린트
//        print("Correct! : \(count)")
//        break
//    }
// //숫자에 따라 결과 프린트.
//    if inputNumber > answer {
//        print("High")
//    }
//
//    if inputNumber < answer {
//        print("Low")
//    }
//
//}

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
    return { printInputResult(checkInputText(answer)) }
}

    //인풋에 따라 결과 프린트.
func printInputResult(_ result: Result) -> Bool {
    switch result {
    case .correct: return true
    default:
        print(result.rawValue)
        return false
    }
}
 
    // 텍스트를 받아 올바른 문자열인지 체크
func checkInputText(_ answer: Int) -> Result {
    guard let userInput = Int(readLine() ?? "") else { return .wrong }
    
    if userInput > answer { return .high }
    if userInput < answer { return .low }
    
    return .correct
}


let corrected: (Int) -> Void = { i in print("Correct! : \(i)") }
func loop(count: Int, stopLoop: @escaping( () -> Bool ), _ finished: (Int)->Void ) {
    
    func counter(_ count: Int) -> Int {
        return stopLoop() ? count : counter(count+1)
    }

    finished(counter(0))

}


loop(count: 0, stopLoop: inputAndCheck(generateAnswer(1,100)), corrected)



//50
//Low
//80
//High
//70
//High
//60
//High
//55
//Correct! : 4
