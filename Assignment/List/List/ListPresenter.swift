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
///  ListPresenter.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///

import Foundation
import UIKit

class ListPresenter: ListViewToPresenterProtocol {
    
    weak var view: ListPresenterToViewProtocol?
    var interactor: ListPresenterToInteractorProtocol?
    var router: ListPresenterToRouterProtocol?
    
    var data: [ArticleModel?] = []
    var categories: [CategoryModel] = []
    var totalCounts: Int = 0
    var isLoading: Bool = false
    var isLoadMore: Bool = false
    
    var page: Int = 0
    var category: String = ""
    
    func selectCategory(_ category: String) {
        self.page = 1
        self.category = category
        
        self.data.removeAll()
        
        if !self.isLoading {
            interactor?.fetch(category: self.category, page: page)
        }
        self.isLoading = true
    }
    
    func fetch() {
        if !self.isLoading {
            interactor?.fetch(category: self.category, page: page)
        }
        self.isLoading = true
    }
    
    func getCategories() {
        interactor?.getCategories(items: [
            "business",
            "entertainment",
            "general",
            "health",
            "science",
            "sports",
            "technology"
        ].map {
            CategoryModel(name: $0.lowercased(), isSelected:  $0.lowercased() == "general")
        })
    }
    
    func loadMore() {
        if !isLoadMore {
            self.page += 1
            interactor?.fetch(category: self.category,
                              page: self.page)
        }
        isLoadMore = true
    }

    func goToDetail(index: Int, source: UIViewController?) {
        let data = data[index]
        router?.goToDetail(data: data, source: source)
    }
}

extension ListPresenter: ListInteractorToPresenterProtocol {
   
    func getCategories(items: [CategoryModel]) {
        categories = items
        view?.getCategories()
    }
    
    func getArticles(items: [ArticleModel?], totalCount: Int) {
        self.totalCounts = totalCount
        if self.page == 1 {
            data = items
        } else {
            data += data.filter { !items.contains($0) }
        }
        self.isLoading = false
        self.isLoadMore = false
        view?.getArticles()
    }
    
    func getArticlesError(message: String?) {
        view?.getArticlesError(message: message)
    }
    
}
