//
//  NewsCombineTests.swift
//  NewsCombineTests
//
//  Created by kz on 20/03/2023.
//

import XCTest

final class NewsCombineTests: XCTestCase {

    func testFormatDate() {
        let news = News(source: Source(id: nil, name: "Test source"), author: "Test author", title: "Test title", description: "Test description", url: "https://testurl.com", urlToImage: "https://testurl.com/image.jpg", publishedAt: "2023-03-20T12:34:56Z", content: "Test content")
        XCTAssertEqual(news.formattedDate, "20-03-2023")
    }


}
