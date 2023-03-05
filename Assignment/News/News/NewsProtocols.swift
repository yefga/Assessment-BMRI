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
///  NewsProtocols.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///

import Foundation
import UIKit

//MARK: Presenter
protocol NewsViewToPresenterProtocol: AnyObject {

    var view: NewsPresenterToViewProtocol?{ get set }
    var interactor: NewsPresenterToInteractorProtocol? {get set}
    var router: NewsPresenterToRouterProtocol? {get set}

    /// Add here your methods to communicate between VIEW -> PRESENTER
    func display()
}

//MARK: View
protocol NewsPresenterToViewProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> VIEW
    func show(news: ArticleModel)
}

//MARK: Interactor - Input
protocol NewsPresenterToInteractorProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> INTERACTOR
    var presenter: NewsInteractorToPresenterProtocol?  { get set }
}

//MARK: Interactor - Output
protocol NewsInteractorToPresenterProtocol: AnyObject {

    /// Add here your methods to communicate between INTERACTOR -> PRESENTER    
  
}

//MARK: Router
protocol NewsPresenterToRouterProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> ROUTER (WIREFRAME)
    func createModule(data: ArticleModel?)-> UIViewController?

}
