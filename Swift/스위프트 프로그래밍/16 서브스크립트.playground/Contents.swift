import Foundation

struct Student {
    var name: String
    var number: Int
}
class School {
    var numbar: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.numbar)
        self.students.append(student)
        self.numbar += 1
    }
    
//    subscript(index: Int) -> String { // 읽기 전용
//        if index < self.numbar {
//            return self.students[index].name
//        }
//        return "subscript -> outOfIndex"
//    }
    
    subscript(index: Int) -> Student? {
        get {
            if index < self.numbar {
                return self.students[index]
            }
            return nil
        }
        
        set {
            guard var newStudent: Student = newValue else {
                return
            }
             
            
            var number: Int = index
            
            if index > self.numbar {
                number = self.numbar
                self.numbar += 1
            }
            
            newStudent.name = "subscript ## \(newStudent.name)"
            newStudent.number = number
            self.students[number] = newStudent
        }
    }
    
    subscript(name: String) -> Int? { // 오버로드 가능
        get {
            return self.students.filter{ $0.name == name }.first?.number
        }
            
    }
}

let school = School()
school.addStudent(name: "Eden")
school.addStudent(name: "Ebi")
 
//school[1]?.name // "Ebi"
//school[2] // subscript -> outOfIndex

school[0] = Student(name: "Parkbi", number: 30)
print(school[0]?.name) // subscript ## Parkbi


print(school["Ebi"])
