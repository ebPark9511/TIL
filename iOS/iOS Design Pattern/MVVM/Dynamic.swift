//
//  Dynamic.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

//https://riptutorial.com/ko/ios/example/27354/%EB%A6%AC-%EC%95%A1%ED%8B%B0%EB%B8%8C-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%B4%EC%97%86%EB%8A%94-mvvm
// MVVM을 테스트 하기 위한 Dynamic 클래스를 위 URL에서 제공 받았습니다.
import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    // 클로저 bind 후 바로 동작.
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    // KVO로 동작하여 값이 바뀌면(didSet) bind 해두었던 listener 클로저를 수행.
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
