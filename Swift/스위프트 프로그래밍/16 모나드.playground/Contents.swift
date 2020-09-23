import Foundation
 

// 맵과 컴팩트맵의 차이
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map{ $0 } // [Optional(1), Optional(2), nil, Optional(5)]
let compactMapped: [Int] = optionals.compactMap{ $0 } // [1, 2, 5]
 



// 삼중 컨테이너.
let multiOptionals = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multiOptionals.map{ $0.map{ $0 } } // [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]
let flatmappedMultipleContainer = multiOptionals.flatMap{ $0.compactMap{ $0 } } // [1, 2, 3, 4, 5]
 
