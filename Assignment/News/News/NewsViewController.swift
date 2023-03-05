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
///  NewsViewController.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///

import UIKit
import AssignmentKit

class NewsViewController: UIViewController {

    var presenter: NewsViewToPresenterProtocol?
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private lazy var authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    private lazy var linkButton = UIButton().then {
        $0.setTitle("Visit Page", for: .normal)
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    lazy var stack = VStack {
        titleLabel
        authorLabel
        descriptionLabel
        contentLabel
        linkButton
    }.setSpacing(16)
        .setAlignment(.leading)
        .setDistribution(.equalSpacing)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.display()
    }
    
    func setupUI() {
        view.addSubview(stack)
        view.backgroundColor = .white
        stack.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
}


extension NewsViewController:  NewsPresenterToViewProtocol {
    func show(news: ArticleModel) {
        self.title = news.source?.name
        titleLabel.text = news.title
        authorLabel.text = "Author: \(news.author ?? "")"
        linkButton.onClick = {
            if let url = news.url {
                UIApplication.shared.open(URL(string: url)!)
            }
        }
        if news.content?.isEmpty ?? false {
            contentLabel.removeFromSuperview()
        } else {
            contentLabel.text = news.content
        }
        if news.description?.isEmpty ?? false {
            descriptionLabel.removeFromSuperview()
        } else {
            descriptionLabel.text = news.description
        }
    }

}
