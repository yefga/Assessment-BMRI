//
//  AssignmentTests.swift
//  AssignmentTests
//
//  Created by yepz on 04/03/23.
//

import XCTest
@testable import Assignment
@testable import AssignmentNetwork
import Alamofire

final class ListInteractorTests: XCTestCase {

    var sut: ListInteractor?
    var mockOutput: ListInteractorOutput?
    var network: InteractorClient?
    override func setUp() {
        sut = ListInteractor()
        mockOutput = ListInteractorOutput()
        network = InteractorClient()
        sut = .init(presenter: mockOutput, network: network)
    }

    func testFetchCategoriesEmpty() {
        sut?.getCategories(items: [])
        XCTAssertEqual(mockOutput?.categories.isEmpty, true)
    }
    
    func testFetchCategoriesNotEmpty() {
        sut?.getCategories(items: [.mock])
        XCTAssertEqual(mockOutput?.categories.isEmpty, false)
    }
    
    func testFetchListSuccess() {
        network?.isSuccess = true
        network?.jsonString = """
        {
            "status": "ok",
            "totalResults": 2,
            "articles": [
                {
                    "source": {
                        "id": "1",
                        "name": "CNN"
                    },
                    "author": "John Doe",
                    "title": "Breaking News",
                    "description": "Lorem ipsum dolor sit amet",
                    "url": "https://www.example.com",
                    "urlToImage": "https://www.example.com/image.jpg",
                    "publishedAt": "2023-03-04T07:04:01Z",
                    "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                },
                {
                    "source": {
                        "id": "2",
                        "name": "BBC"
                    },
                    "author": "Jane Smith",
                    "title": "World News",
                    "description": null,
                    "url": "https://www.example.com/world-news",
                    "urlToImage": null,
                    "publishedAt": "2023-03-04T07:04:01Z",
                    "content": "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium."
                }
            ]
        }

        """
        sut?.fetch(category: "Something", page: 1)
        XCTAssertEqual(network?.isSuccess, true)
        XCTAssertEqual(mockOutput?.articles.isEmpty, false)
        XCTAssertEqual(mockOutput?.totalCounts, 2)
    }
    
    func testFetchListFailed() {
        network?.isSuccess = false
        sut?.fetch(category: "Something", page: 1)
        XCTAssertEqual(network?.isSuccess, false)
        XCTAssertEqual(mockOutput?.articles.isEmpty, true)
        XCTAssertEqual(mockOutput?.totalCounts, 0)
    }
    
    override func tearDown() {
        sut = nil
        mockOutput = nil
        network = nil
    }
}

extension String {
    func decode<T: Codable>(model: T.Type) -> T? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(model, from: data)
            return object
        } catch {
            print("Error decoding JSON string: \(error.localizedDescription)")
            return nil
        }
    }
}



class InteractorClient: APIClientProtocol {
    var isSuccess: Bool = false
    var jsonString: String = ""
    
    func request<T: Codable>(url: URLRequestConvertible,
                    forModel model: T.Type,
                    completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable, T : Encodable {
        print(jsonString)
        if isSuccess, let decoded = jsonString.decode(model: model) {
            completion(.success(decoded))
        } else {
            completion(.failure(APIError.decodeFailed))
        }
    }
}

class ListInteractorOutput: ListInteractorToPresenterProtocol {
    
    var categories: [CategoryModel] = []
    var articles: [ArticleModel?] = []
    var totalCounts: Int = 0
    var errorArticles: String?
    
    func getCategories(items: [CategoryModel]) {
        self.categories = items
    }
    
    func getArticles(items: [ArticleModel?], totalCount: Int) {
        self.articles = items
        self.totalCounts = totalCount
    }
    
    func getArticlesError(message: String?) {
        self.errorArticles = message
    }
    
}
