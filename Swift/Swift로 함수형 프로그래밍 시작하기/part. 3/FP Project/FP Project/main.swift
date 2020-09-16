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

let fizz = { i in i % 3 == 0 ? "fizz" : "" }
let buzz = { i in i % 5 == 0 ? "buzz" : "" }
let fizzbuzz: (Int) -> String = { i in { a, b in b.isEmpty ? a : b }("\(i)", fizz(i) + buzz(i))}
  
func loop(min: Int, max: Int, excute: (Int) -> Void) {
    Array(min...max).forEach(excute)
}

loop(min: 1, max: 100, excute: { print(fizzbuzz($0)) })
