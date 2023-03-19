//
//  NewsCard.swift
//  NewsCombine
//
//  Created by kz on 17/03/2023.
//

import SwiftUI

struct NewsCard: View {
    
    @StateObject private var imageLoader = ImageLoader()
    @Environment(\.colorScheme) var colorScheme

    var news: News
    var body: some View {
        HStack(spacing: 0){
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
                    .padding(5)
            }
            VStack{
                Text(news.title)
                    .padding(.horizontal, 10)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
                HStack{
//                    Text(news.source)
//                        .font(.footnote)
//                        .foregroundColor(.gray)
//                        .padding(.horizontal)
                    Spacer()
                    Text(news.author ?? "")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 5)
                }
            }
        }
        .background(.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal, 10)
        .onAppear {
            if news.urlToImage != nil{
                imageLoader.loadImage(with: URL(string: news.urlToImage!)!)
            }
        }
    }
}

