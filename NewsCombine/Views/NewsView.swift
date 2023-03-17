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
                    Text(article.description!)
                }
            }

        }
        .onAppear{
            newsViewModel.getNews()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("News")
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
