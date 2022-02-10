//
//  LocalJSONView.swift
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

struct LocalJSONView: View {
    @State private var animals: [Animal] = [Animal(id: 0, name: "", age: 0, type: "")]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(animals) { animal in
                    Text("\(animal.name) is a \(animal.type) and is \(animal.age) years old.")
            }
        }
        .onAppear(perform: {
            dealJSON()
        })
    }
    
    func dealJSON(){
        //定义路径
        let path = Bundle.main.path(forResource: "animalData", ofType: "json")!
        //定义url
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Animal].self, from: data)
            animals = decodedData
        } catch {
            print(error)
        }
    }
}

struct LocalJSONView_Previews: PreviewProvider {
    static var previews: some View {
        LocalJSONView()
    }
}
