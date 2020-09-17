//
//  main.swift
//  FP Project
//
//  Created by 박은비 on 2020/09/10.
//  Copyright © 2020 박은비. All rights reserved.
//

import Foundation

/*
    fizz출력하는애
    buzz 출력하는애
 
    1~100 까지 루프하여 위 둘을 호출함
 
 */

//let fizz = { i in i % 3 == 0 ? "fizz" : "" }
//let buzz = { i in i % 5 == 0 ? "buzz" : "" }
//let fizzbuzz: (Int) -> String = { i in { a, b in b.isEmpty ? a : b }("\(i)", fizz(i) + buzz(i))}
//
//func loop(min: Int, max: Int, excute: (Int) -> Void) {
//    Array(min...max).forEach(excute)
//}
//
//loop(min: 1, max: 100, excute: { print(fizzbuzz($0)) })


import Foundation

let answer = Int(arc4random() % 100) + 1
//var count = 0
//
//while true {
//
//    let userInput = readLine()
//
//    guard let unwrappedInput = userInput, let inputNumber = Int(unwrappedInput) else {
//        print("Wrong")
//        continue
//    }
//
//    if inputNumber == answer {
//        print("Correct! : \(count)")
//        break
//    }
//
//    if inputNumber > answer {
//        print("High")
//    }
//
//    if inputNumber < answer {
//        print("Low")
//    }
//
//    count += 1
//}

// 1. 카운트를 제거한다.

func countingloop(ㄷ) {
    func counting(_ c: Int) {
        if c == 10 { return }
        print(c)
        counting(c+1)
    }
    counting(0)
}

countingloop()
