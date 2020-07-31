//
//  Product.swift
//  iOS
//
//  Created by 은비 on 2020/08/02.
//

import SwiftUI

struct Product {
  var image: UIImage?
  var name: String
  var detail: String?
}

extension Product {
  static func all() -> [Product] {
    return [
        
        Product(image: UIImage(named: "sample_1"), name: "잼", detail: "달콤한 잼들."),
        Product(image: UIImage(named: "sample_2"), name: "바나나", detail: "노란 바나나."),
        Product(image: UIImage(named: "sample_3"), name: "노란 파프리카", detail: "노랗다."),
        Product(image: UIImage(named: "sample_4"), name: "빨간 파프리카", detail: "빨갛다."),
        Product(image: UIImage(named: "sample_5"), name: "피자")
    ]
  }
}
