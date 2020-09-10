import Foundation

/*
 
 Pure Fuction (= 순수함수)
 
 output을 만들때 input만 사용한다.
 
 */

// 주어진 코드에서 외부변수를 사용하지 않는 순수함수로 변경하세요
func solution(_ nums: [Int]) -> Int {
    return nums.reduce(0) { (s1, s2) -> Int in
        return s1 + s2
    }
}

solution([1,2,3])
