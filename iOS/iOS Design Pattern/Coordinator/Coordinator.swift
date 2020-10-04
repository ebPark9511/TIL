//
//  Coordinator.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/04.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set } // 확장 할수 있도록 자식 코디네이터를 저장할 속성
    var navigation: UINavigationController { get set } // 뷰컨을 표시할때 사용되는 탐색 컨트롤러를 저장하는 속성.

    func start() // 코디네이터를 완전히 만들고 준비가 되었을 때만 활성화 할 수 있습니다.
}

protocol Storyboarded {
    static func instantiate() -> Self // 식별자로 뷰컨트롤러를 찾는 역할
}
 
extension Storyboarded where Self: UIViewController { // where Self를 사용함으로써 프로토콜 준수 제약 추가.
    // where Self: 이 프로토콜을 사용하는것은 UIViewController만임을 명시한다.
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self) // 자기자신의 클래스네임을 가져옴
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self 
    }
}

 
