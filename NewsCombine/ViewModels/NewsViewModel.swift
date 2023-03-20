//
//  NewsViewModel.swift
//  NewsCombine
//
//  Created by kz on 17/03/2023.
//

import Foundation
import Combine


class NewsViewModel: ObservableObject{   
    @Published var news = [News]()
    @Published var newsByQuote = [News]()

    private var cancellable: AnyCancellable?
    private var cancellablePrompt: AnyCancellable?

    private var API_KEY = "API_KEY"
    
    func getNews(){
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)") else { fatalError("invalid url")}
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
    
    func getNewsPrompt(_ prompt: String, page: Int, pageSize: Int = 15) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(prompt)&sortBy=popularity&page=\(page)&pageSize=\(pageSize)&apiKey=\(API_KEY)") else { fatalError("invalid url")}
        let urlRequest = URLRequest(url: url)
        
        cancellablePrompt = URLSession.shared.dataTaskPublisher(for: urlRequest)
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
                if page == 1 {
                    self?.newsByQuote = news
                } else {
                    self?.newsByQuote.append(contentsOf: news)
                }
            })
    }
    
//    func loadMoreNews(_ prompt: String, page: Int = 1, pageSize: Int = 15) {
//        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(prompt)&sortBy=popularity&page=\(page)&pageSize=\(pageSize)&apiKey=\(API_KEY)") else { fatalError("invalid url")}
//        let urlRequest = URLRequest(url: url)
//
//        cancellablePrompt = URLSession.shared.dataTaskPublisher(for: urlRequest)
//            .map { $0.data }
//            .decode(type: NewsResponse.self, decoder: JSONDecoder())
//            .map { $0.articles }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Request error: \(error.localizedDescription)")
//                case .finished:
//                    break
//                }
//            }, receiveValue: { [weak self] news in
//                if page == 1 {
//                    self?.newsByQuote = news
//                } else {
//                    self?.newsByQuote.append(contentsOf: news)
//                }
//            })
//    }


}
