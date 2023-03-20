//
//  News.swift
//  NewsCombine
//
//  Created by kz on 16/03/2023.
//
import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [News]
}

// MARK: - Article
struct News: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    var formattedDate: String{
        return formatDate(publishedAt)
    }
    
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd'T'HH-mm-ssZ"
        
        if let date = dateFormatter.date(from: dateString){
            dateFormatter.dateFormat = "dd-MM-yyy"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
