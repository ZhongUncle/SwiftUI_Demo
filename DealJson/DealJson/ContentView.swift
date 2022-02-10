//
//  ContentView.swift
//  DealJson
//
//  Created by 钟宜江 on 2022/2/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("本地 JSON 生成的动物介绍")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                    .padding([.top, .trailing])
                LocalJSONView()
                
                Text("HTTP JSON 获取的英文笑话")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                    .padding([.top, .trailing])
                HTTP_jsonView()
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
