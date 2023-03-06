//
//  ListPresenterTests.swift
//  AssignmentTests
//
//  Created by yepz on 06/03/23.
//

import XCTest
@testable import Assignment
@testable import AssignmentNetwork

final class ListPresenterTests: XCTestCase {
    
    var sut: ListPresenter?
    var mockView: MockListView?
    var mockRouter: MockListRouter?
    var mockInteractor: MockListInteractor?

    override func setUp() {
        sut = ListPresenter()
        mockView = MockListView()
        mockRouter = MockListRouter()
        mockInteractor = MockListInteractor()
        mockInteractor?.presenter = sut
        sut?.view = mockView
        sut?.interactor = mockInteractor
        sut?.router = mockRouter
        super.setUp()
    }
    
    func testCategoriesEmpty() {
        sut?.getCategories(items: [])
        XCTAssertEqual(sut?.categories.isEmpty, true)
    }
    
    func testCategoriesNotEmpty() {
        sut?.getCategories(items: [.mock])
        XCTAssertEqual(sut?.categories.count, 1)
    }
    
    func testListNotEmpty() {
        sut?.getArticles(items: NewsModel.mock.articles, totalCount: 2)
        XCTAssertEqual(sut?.totalCounts, 2)
        XCTAssertFalse(sut?.data.count == 2)
        
        mockView?.categoriesIsNotEmpty = true
        XCTAssertTrue(mockView?.categoriesIsNotEmpty ?? true)
    }
    
    func testListEmpty() {
        sut?.getArticles(items: [], totalCount: 0)
        XCTAssertEqual(sut?.totalCounts, 0)
        XCTAssertTrue(sut?.data.isEmpty ?? true)
    }
    
    func testView() {
        mockView?.articlesError = true
        mockView?.articlesAvailable = true
        mockView?.setupSuccess = true
        
        XCTAssertTrue(mockView?.setupSuccess ?? true)
        XCTAssertTrue(mockView?.articlesError ?? true)
        XCTAssertTrue(mockView?.articlesAvailable ?? true)
    }
    
    func testROuter() {
        XCTAssertNotNil(mockRouter?.createModule())
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockRouter = nil
    }
}

class MockListView: ListPresenterToViewProtocol {
    var categoriesIsNotEmpty: Bool = false
    var setupSuccess: Bool = false
    var articlesAvailable: Bool = false
    var articlesError: Bool = false
    func setupUI() {
        setupSuccess = true
    }
    
    func getCategories() {
        categoriesIsNotEmpty = true
    }
    
    func getArticles() {
        articlesAvailable = true
    }
    
    func getArticlesError(message: String?) {
        articlesError = true
    }
    
    
}

class MockListRouter: ListPresenterToRouterProtocol {
    func createModule() -> ListViewController {
        return ListViewController()
    }
    
    func goToDetail(data: ArticleModel?, source: UIViewController?) {
        
    }
    
    
}

class MockListInteractor: ListPresenterToInteractorProtocol {
    var presenter: ListInteractorToPresenterProtocol?
    var isEmpty: Bool = false
    
    func fetch(category: String, page: Int) {

    }
    
    func getCategories(items: [CategoryModel]) {

    }
}
