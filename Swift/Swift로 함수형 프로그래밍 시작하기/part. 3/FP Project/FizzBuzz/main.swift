//
//  main.swift
//  FizzBuzz
//
//  Created by 박은비 on 2020/09/10.
//  Copyright © 2020 박은비. All rights reserved.
//

import Foundation

// FizzBuzz 프로그램은 1 ~ 100 까지의 숫자를 출력하되, 3으로 나누어 떨어진다면 fizz, 5로 나누어 떨어진다면 buzz, 3과 5 둘 다 나누어 떨어지면 fizzbuzz를 출력하는 프로그램 입니다.

 

let fizz = { i in i % 3 == 0 ? "fizz" : "" }
let buzz = { i in i % 5 == 0 ? "buzz" : "" }

let fizzbuzz: (Int) -> String = {  i in { a, b in b.isEmpty ? a : b}("\(i)", fizz(i) + buzz(i)) }

 
func loop(min: Int, max: Int, _ f: (Int)->Void) {
    Array(min...max).forEach(f)
}
 
loop(min: 0, max: 100, { print(fizzbuzz($0)) })
