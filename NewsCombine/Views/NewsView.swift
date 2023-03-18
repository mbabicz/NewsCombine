//
//  NewsView.swift
//  NewsCombine
//
//  Created by kz on 16/03/2023.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView(){
            ScrollView{
                ForEach(newsViewModel.news){ article in
                    NavigationLink(destination: DetailedNewsView(news: article)){
                        NewsCard(news: article)
                    }
                }
            }
            .navigationTitle("News")
        }
        .onAppear{
            newsViewModel.getNews()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
