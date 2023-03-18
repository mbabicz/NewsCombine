//
//  NewsViewModel.swift
//  NewsCombine
//
//  Created by kz on 17/03/2023.
//

import Foundation
import Combine


class NewsViewModel: ObservableObject{
    //
    //    @Published var news = [News]()
    //
    //    func getNews(){
    //        guard let url = URL(string: "https://api.lil.software/news") else { fatalError("invalid url")}
    //        let urlRequest = URLRequest(url: url)
    //
    //        let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
    //            if let error = error {
    //                print("Request error: \(error.localizedDescription)")
    //                return
    //            }
    //            guard let response = response as? HTTPURLResponse else { return }
    //
    //            if response.statusCode == 200 {
    //                guard let data = data else { return }
    //                print(String(data: data, encoding: .utf8)!)
    //
    //                DispatchQueue.main.async {
    //                    do{
    //                        let decodedNews = try JSONDecoder().decode(NewsResponse.self, from: data)
    //                        self.news = decodedNews.articles
    //                    } catch let error {
    //                        print("Error: \(error)")
    //                    }
    //                }
    //            }
    //        }
    //        dataTask.resume()
    //    }
    
    @Published var news = [News]()
    private var cancellable: AnyCancellable?

    
    func getNews(){
        
        guard let url = URL(string: "https://api.lil.software/news") else { fatalError("invalid url")}
        let urlRequest = URLRequest(url: url)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] news in
                self?.news = news
            })

        
        

    }
    
}
