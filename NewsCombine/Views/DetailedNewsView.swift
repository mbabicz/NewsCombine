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
                    .padding(.horizontal, 10)
                
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }
                Text(news.description ?? "")
                    .padding(.bottom)
                Text(news.content ?? "")
                    .padding(.bottom)
                
                Link("Read more", destination: URL(string: news.url)!)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack{
                    Text(news.source.name).font(.callout)
                    Spacer()
                    Text("\(news.formattedDate)").font(.callout)
                }
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
