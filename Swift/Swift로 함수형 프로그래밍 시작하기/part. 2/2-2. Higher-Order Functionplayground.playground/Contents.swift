import Foundation

/*
 
Higher-Order Function (= 고차함수)
 함수를 매개변수로 받거나 리턴하는 함수
 
 */
 
//주어진 코드는 고차함수를 사용하여 짝수만의 합을 계산하는 코드입니다. 코드를 완성하세요
let f: (Int) -> Bool = { $0 % 2 == 0 } //함수 내부를 구현하세요
let s: (Int, Int) -> Int = { $0 + $1 } //함수 내부를 구현하세요
  
func solution(_ nums: [Int]) -> Int {
    return nums
          .filter(f)
          .reduce(0, s)
}
