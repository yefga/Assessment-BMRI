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
///  ListProtocols.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///

import UIKit
import Foundation

//MARK: Presenter
protocol ListViewToPresenterProtocol: AnyObject {

    var view: ListPresenterToViewProtocol?{ get set }
    var interactor: ListPresenterToInteractorProtocol? {get set}
    var router: ListPresenterToRouterProtocol? {get set}
    
    var data: [ArticleModel?] { get set }
    var categories: [CategoryModel] { get set }
    var totalCounts: Int { get set }
    var isLoading: Bool { get set }
    var isLoadMore: Bool { get set }
    /// Add here your methods to communicate between VIEW -> PRESENTER
    func selectCategory(_ category: String)
    func fetch()
    func loadMore()
    func getCategories()
    func goToDetail(index: Int, source: UIViewController?)
}

//MARK: View
protocol ListPresenterToViewProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> VIEW
    func setupUI()
    func getCategories()
    func getArticles()
    func getArticlesError(message: String?)
}

//MARK: Interactor - Input
protocol ListPresenterToInteractorProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> INTERACTOR
    var presenter: ListInteractorToPresenterProtocol?  { get set }
    func fetch(category: String, page: Int)
    func getCategories(items: [CategoryModel])
}

//MARK: Interactor - Output
protocol ListInteractorToPresenterProtocol: AnyObject {

    /// Add here your methods to communicate between INTERACTOR -> PRESENTER
    func getCategories(items: [CategoryModel])
    func getArticles(items: [ArticleModel?], totalCount: Int)
    func getArticlesError(message: String?)
}

//MARK: Router
protocol ListPresenterToRouterProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> ROUTER (WIREFRAME)
    func createModule()-> ListViewController
    func goToDetail(data: ArticleModel?, source: UIViewController?)
}
