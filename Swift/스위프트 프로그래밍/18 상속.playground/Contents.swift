import Foundation

// 18.2.2 프로퍼티 재정의
class Person {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String {
        return "이름: \(name) . 나이 : \(age)"
    }
}

class Student: Person {
    var grade: String = "A"
    
    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)" // 읽기 프로퍼티를 재정의
    }
    
    override var koreanAge: Int {
        get {//읽기 프로퍼티를 쓰기 프로퍼티로만으로 구현 불가능하므로. 아무 동작 안할시에는 super. 로 처리
            return super.koreanAge
        }
        set {
            self.age = newValue - 1
        }
    }
}
