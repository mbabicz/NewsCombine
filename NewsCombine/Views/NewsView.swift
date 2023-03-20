//
//  NewsView.swift
//  NewsCombine
//
//  Created by kz on 16/03/2023.
//

import SwiftUI

struct NewsView: View {
    @StateObject var newsViewModel = NewsViewModel()
    @State var searchText: String = ""
    @State var currentPage = 1
    
    var body: some View {
        NavigationView(){
            ScrollView{
                if !searchText.isEmpty{
                    ForEach(newsViewModel.newsByQuote){ article in
                        NavigationLink(destination: DetailedNewsView(news: article)){
                            NewsCard(news: article)
                        }

                    }
                    Button(action: {
                        currentPage += 1
                        newsViewModel.getNewsPrompt(searchText, page: currentPage)
                    }, label: {
                        Text("Load more")
                            .padding()
                    })
                } else {
                    ForEach(newsViewModel.news){ article in
                        NavigationLink(destination: DetailedNewsView(news: article)){
                            NewsCard(news: article)
                        }
                    }
                }
            }
            .navigationTitle("News")

        }
        .searchable(text: $searchText)

        .onAppear{
           newsViewModel.getNews()
        }
        .onChange(of: searchText) { searchText in
            newsViewModel.getNewsPrompt(searchText, page: 1)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
