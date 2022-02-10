//
//  LocalJSON.swift
//  DealJson
//
//  Created by 钟宜江 on 2022/2/11.
//

import SwiftUI
import Combine

struct Animal: Decodable, Identifiable {
        var id: Int
        var name: String
        var age: Int
        var type: String
}

struct LocalJSON: View {
    @State private var animals: [Animal] = [Animal(id: 0, name: "", age: 0, type: "")]
    var body: some View {
        VStack {
            ForEach(animals) { animal in
                    Text("\(animal.name) is a \(animal.type) and is \(animal.age) years old.")
            }
        }
    }
    func dealJSON(){
        //定义路径
        let path = Bundle.main.path(forResource: "animalData", ofType: "json")!
        //定义url
        let url = URL(fileURLWithPath: path)
        
    }
}

struct LocalJSON_Previews: PreviewProvider {
    static var previews: some View {
        LocalJSON()
    }
}
