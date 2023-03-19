//
//  DetailedNewsView.swift
//  NewsCombine
//
//  Created by kz on 17/03/2023.
//

import SwiftUI

struct DetailedNewsView: View {
    
    var news: News
    @StateObject private var imageLoader = ImageLoader()
    @ObservedObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                Text(news.title)
                    .font(.headline)
                
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }
                Text(news.description ?? "")
                Link("Read more", destination: URL(string: news.url)!)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                HStack{
//                    Text(news.source).font(.callout)
                    Spacer()
                    Text("\(news.publishedAt)").font(.callout)
                }
                .padding(10)
                Spacer()
            }
            .onAppear {
                if news.urlToImage != nil{
                    imageLoader.loadImage(with: URL(string: news.urlToImage!)!)
                }
            }
        }
    }
}

//struct DetailedNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedNewsView(news: News.sampleNews)
//    }
//}
