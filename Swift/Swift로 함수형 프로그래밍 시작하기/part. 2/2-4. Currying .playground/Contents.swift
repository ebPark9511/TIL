
import Foundation


/*
 Currying
 - 여러개의 파라미터를 받는 함수를 여러개의 함수로 쪼갬.
 */

// 주어진 코드에서 n의 배수만을 모아 합을 구하는 함수 filterSum을 currying 하여 filterSum2를 만드세요

func filterSum(_ ns: [Int], _ n: Int) -> Int {
    return ns.filter({ $0 % n == 0 }).reduce(0, +)
}

func filterSum2(_ n: Int) -> ([Int]) -> Int {
    return { nums in
        return filterSum(nums, n)
    }
}

func solution(_ nums: [Int], _ r: Int) -> Int {
    let filteredR = filterSum2(r)
    return filteredR(nums)
}
