class Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        if nums.isEmpty { return nums }
        return Array<Int>(Set(nums).symmetricDifference(1...nums.count))       
    }
}
