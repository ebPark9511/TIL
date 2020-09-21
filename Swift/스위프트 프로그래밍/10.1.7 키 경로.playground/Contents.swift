import Foundation
 

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

let minsu = Person(name: "minsu")
var bag = Stuff(name: "minsu's bag", owner: minsu)

let yeounghee = Person(name: "yeounghee")
var phone = Stuff(name: "yeounghee's iPhone", owner: yeounghee)

/* 클래스 - 참조 형태 ReferenceWritableKeyPath<KeyPathClass, String>  */
let personName = \Person.name
/* 구조체 - 값형태 "WritableKeyPath<Stuff, String>\n" */
let stuffName = \Stuff.name


print(type(of: personName)) // ReferenceWritableKeyPath<Person, String>
print(type(of: stuffName)) // WritableKeyPath<Stuff, String>

 

// 경로의 추가
let stuffOwner = \Stuff.owner
let stuffOwnerPath = stuffOwner.appending(path: \.name)
// \. -> \.self 를 축약
// \.self란 인스턴스 그 자체를 표현하는 키 경로.

 
 print(type(of: stuffOwner)) // WritableKeyPath<Stuff, Person>
 print(type(of: stuffOwnerPath)) // ReferenceWritableKeyPath<Stuff, String>


// 키 경로와 서브 스크립트를 이용해 값을 가져온다.
// 인스턴스에 상관없이 keyPath로 값을 가져올수 있다. (유연성)
print("물건의 이름: ", bag[keyPath: stuffName])
print("물건의 주인: ", bag[keyPath: stuffOwnerPath])
 
print("물건의 이름: ", phone[keyPath: stuffName])
print("물건의 주인: ", phone[keyPath: stuffOwnerPath])


// 수정도 가능함
bag[keyPath: stuffOwner] =  yeounghee
bag[keyPath: stuffName] = "yeounghee's bag"
 
print("물건의 이름: ", bag[keyPath: stuffName])
print("물건의 주인: ", bag[keyPath: stuffOwnerPath])
