# 201002 MVVM

---
- 기존 MVC 패턴이 비대해짐에 따라 비즈니스 로직을 분리하여 만들수 있도록 MVVM 패턴이 도입 되었다.

![201002 MVVM_000](./image/200828_dSYM_000.png)


## ViewModel
- ViewModel과 View의 data binding시에는 rx가 주로 사용된다.

- View와 Model사이에 중개자 역할을 하며 뷰 로직을 처리함.


ViewModel은 Model 클래스의 메서드를 호출하여 모델과 상호 작용함. 

ViewModel은 View에서 쉽게 사용할 수 있는 형식으로 Model의 데이터를 제공함.

ViewModel은 Model에서 데이터를 검색 후 다음 View에서 데이터를 사용할수 있게 하고

View에서는 간단하게 처리 할 수 있도록 데이터 형식을 다시 지정할 수 있음.



## Sample Project 



- 참고 URL


[https://riptutorial.com/ko/ios/example/27354/%EB%A6%AC-%EC%95%A1%ED%8B%B0%EB%B8%8C-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%B4%EC%97%86%EB%8A%94-mvvm](https://riptutorial.com/ko/ios/example/27354/%EB%A6%AC-%EC%95%A1%ED%8B%B0%EB%B8%8C-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%B4%EC%97%86%EB%8A%94-mvvm)  
[https://eunjin3786.tistory.com/31](https://eunjin3786.tistory.com/31) 
 
 
