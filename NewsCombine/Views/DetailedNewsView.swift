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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0) {
                Text(news.title)
                    .font(.title)
                    .padding(5)
                    .cornerRadius(12)
                if imageLoader.image != nil {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding([.horizontal, .top], 5)
                }
                HStack{
                    Text(news.source.name).font(.callout)
                    Spacer()
                    Text("\(news.formattedDate)").font(.callout)
                }
                .padding(10)
                .foregroundColor(.gray)
                Text(news.description ?? "")
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                Divider()
                Text(news.content ?? "")
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                Divider()
                
                Link("Read more", destination: URL(string: news.url)!)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
