//
//  ContentView.swift
//  iOS
//
//  Created by 박은비 on 2020/07/31.
//

import SwiftUI 
  
 
struct ContentView: View {
    let products = Product.all()
     
    var selectedDetail: String = ""
    
    var body: some View {
        List(products, id: \.name) { item in
            ProductCell(product: item)
                
           }
    }
}
struct ProductCell: View {
    @State var isPresent: Bool = false
    
    let product: Product

    var body: some View {
        HStack {
            Image(uiImage: product.image!)
                    .resizable()
                    .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 5.0, content: {
                Text(product.name)
                    .bold()
                Text(product.detail ?? "")
                    .colorMultiply(.gray)
            })
        }.onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/,
                      perform: {
                        #if APPCLIP
                        // 앱 클립일땐 미동작
                        #else
                        self.isPresent = true 
                        #endif
        })
        .alert(isPresented: $isPresent,
               content: {
                Alert(title: Text(product.detail ?? "-"),
                      dismissButton: .default(Text("OK")))

        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
