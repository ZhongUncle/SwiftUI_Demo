//
//  HTTP_jsonView.swift
//  DealJson
//
//  Created by 钟宜江 on 2022/2/11.
//

import SwiftUI
import Combine

struct Joke: Codable {
    var id: String
    var joke: String
    var status: Int
}

struct HTTP_jsonView: View {
    //来获取和存储解码后的数据的Joke数据类型的变量
    @State private var jokes: Joke = Joke(id: "", joke: "", status: 0)

    var body: some View {
        VStack {
            Button("获取") {
                getJoke()
            }
            VStack(alignment: .leading) {
                Text(jokes.joke)
            }
            .onAppear(perform: {
                //界面出现的时候加载数据
                getJoke()
            })
        }
    }
    
    func getJoke() {
        //设置需要获取的网址
        let url = URL(string: "https://icanhazdadjoke.com/")!
        //请求网址
        var urlRequest = URLRequest(url:url)
        //请求获取的类型是application/json（也就是JSON类型）
        urlRequest.addValue("application/json",forHTTPHeaderField: "Accept")
        //检查获取到的数据
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                //将数据赋值给jokeDate，并且判断数据不为空的话
                if let jokeData = data {
                    //设置解码器为JSONDecoder()
                    let decoder = JSONDecoder()
                    //按照我们之前创建的Joke结构体的数据结构解码获取到的数据（如果我们打算放到数组中，给这里的Joke加个中括号）
                    let decodedData = try decoder.decode(Joke.self, from: jokeData)
                    //为了防止数据过多，加载时间过长，这里使用异步加载
                    DispatchQueue.main.async {
                        //将解码后的数据赋值给之前准备好的空变量
                        self.jokes = decodedData
                    }
                } else {
                    //如果数据是空的，在控制台输出下面的文本
                    print("No data")
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct HTTP_jsonView_Previews: PreviewProvider {
    static var previews: some View {
        HTTP_jsonView()
    }
}
