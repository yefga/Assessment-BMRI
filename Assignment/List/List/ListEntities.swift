/// Copyright © 2023. Assignment. All rights reserved.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///
///  ListEntities.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///


import Foundation

struct CategoryModel: Equatable {
    let name: String
    var isSelected: Bool = false
}

extension CategoryModel {
    static var mock: CategoryModel {
        .init(name: "general")
    }
}


// MARK: - Welcome
struct NewsModel: Codable, Equatable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleModel?]
}

extension NewsModel {
    static var mock: NewsModel {
        let source1 = SourceModel(id: "1", name: "CNN")
        let source2 = SourceModel(id: "2", name: "BBC")
        let article1 = ArticleModel(
            source: source1,
            author: "John Doe",
            title: "Breaking News",
            description: "Lorem ipsum dolor sit amet",
            url: "https://www.example.com",
            urlToImage: "https://www.example.com/image.jpg",
            publishedAt: "2023-03-04T07:04:01Z",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        )
        let article2 = ArticleModel(
            source: source2,
            author: "Jane Smith",
            title: "World News",
            description: nil,
            url: "https://www.example.com/world-news",
            urlToImage: nil,
            publishedAt: "2023-03-04T07:04:01Z",
            content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium."
        )
        let articles = [article1, article2]
        return NewsModel(status: "ok", totalResults: 2, articles: articles)
    }
}


// MARK: - Article
struct ArticleModel: Codable, Equatable {
    let source: SourceModel?
    let author, title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct SourceModel: Codable, Equatable {
    let id: String?
    let name: String?
}
