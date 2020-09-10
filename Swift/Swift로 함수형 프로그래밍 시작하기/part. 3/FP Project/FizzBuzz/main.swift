//
//  main.swift
//  FizzBuzz
//
//  Created by 박은비 on 2020/09/10.
//  Copyright © 2020 박은비. All rights reserved.
//

import Foundation

// FizzBuzz 프로그램은 1 ~ 100 까지의 숫자를 출력하되, 3으로 나누어 떨어진다면 fizz, 5로 나누어 떨어진다면 buzz, 3과 5 둘 다 나누어 떨어지면 fizzbuzz를 출력하는 프로그램 입니다.

 

func fizzbuzz(n: Int) -> String {
    let result = fizz(n: n) + buzz(n: n)
    if result == "" {
        return "\(n)"
    }
    return result
}
 
func fizz(n: Int) -> String {
    if n % 3 == 0 { return "fizz" }
    return ""
}
 
func buzz(n: Int)  -> String {
    if n % 5 == 0 { return "buzz" }
    return ""
}

func loop(min: Int, max: Int, _ f: (Int)->Void) {
    for i in min...max {
        f(i)
    }
}

func f(_ i: Int) {
    print(fizzbuzz(n: i))
}
 
loop(min: 0, max: 100, f)
