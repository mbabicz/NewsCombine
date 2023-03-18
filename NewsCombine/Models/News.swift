//
//  News.swift
//  NewsCombine
//
//  Created by kz on 16/03/2023.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [News]
}

struct News: Codable, Identifiable {
    let id = UUID()
    let author: String?
    let url: String
    let source: String
    let title: String
    let description: String
    let image: String
    let date: String
    
    var formattedDate: String {
        return formatDate(date)
    }
    
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }


}

extension News {
    static var sampleNews: News {
        return News(
            author: "Clea Caulcutt",
            url: "https://www.politico.eu/article/macron-invokes-nuclear-option-to-force-through-his-pensions-reform-in-huge-political-setback/",
            source: "POLITICO.eu",
            title: "Macron invokes nuclear option to push through pensions reform in huge political setback - POLITICO Europe",
            description: "French President Emmanuel Macron bypassed parliament to get his flagship reform over the line, risking backlash from politicians and protesters that could wreck his presidency.",
            image: "https://www.politico.eu/cdn-cgi/image/width=1200,height=630,fit=crop,quality=80,onerror=redirect/wp-content/uploads/2023/03/16/GettyImages-1248370467-scaled.jpg",
            date: "2023-03-16T14:21:00Z"
        )
    }
}







