import Foundation

/*
 
Compostion
 - 합성: 함수의 반환값이 타 함수의 입력 값으로 사용 되는 것
 */

// 주어진 코드는 짝수만의 합을 계산하는 코드입니다. 함수의 합성을 이용하여 완성하세요
func comp<A, B, C>(_ pf1: @escaping (A) -> B,
                   _ pf2: @escaping (B) -> C) -> (A) -> C {
    return { i in
        return pf2(pf1(i))
    }
}

func filterEven(_ ns: [Int]) -> [Int] {
    return ns.filter{ $0 % 2 == 0}
}

func sum(_ ns: [Int]) -> Int {
    return ns.reduce(0, { $0 + $1 })
}

let filteredSum = comp(filterEven, sum)

func solution(_ nums: [Int]) -> Int {
    return filteredSum(nums)
}
