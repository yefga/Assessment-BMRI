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
///  ListViewController.swift
///  Assignment
///
///  Created by yepz on 05/03/23.
///  Using Swift 5.0
///  Running on macOS 13.2
///

import UIKit
import AssignmentKit

class ListViewController: UIViewController {
    
    private let tableCell: String = "ListCell"
    private lazy var pickerView = UIPickerView().then {
        $0.delegate = self
    }
    private lazy var textField = UITextField().then {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        $0.inputView = pickerView
        $0.inputAccessoryView = toolBar
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.placeholder = "Select Category"
        $0.textAlignment = .center
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        $0.textColor = .systemBlue
    }
    
    private lazy var listTableView = UITableView(
        frame: .zero,
        style: .plain
    ).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundView = emptyView
        $0.registerCells(ListCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private lazy var loadTableIndicator = UIActivityIndicatorView(style: .medium).then {
        $0.tintColor = .black
        $0.hidesWhenStopped = true
    }
    
    private lazy var loadMoreIndiator = UIActivityIndicatorView(style: .medium).then {
        $0.tintColor = .black
        $0.hidesWhenStopped = true
    }
    
    
    private lazy var emptyView = VStack {
        UIImageView().then {
            $0.image = .init(named: "waiting")
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints {
                $0.width.equalTo(UIScreen.main.bounds.width)
                $0.height.equalTo(200)
            }
        }
        UILabel().then {
            $0.text = "Getting Started"
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textAlignment = .center
        }
        
        UILabel().then {
            $0.textAlignment = .center
            $0.text = "Select the category to discover\npopular news in this page"
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }.setSpacing(8)
        .setAlignment(.center)
        .setDistribution(.equalSpacing)
    
    var presenter: ListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getCategories()
    }
    
    @objc private func donePicker(sender: UIToolbar) {
        self.view.endEditing(true)
        
        if let name = textField.text?.lowercased(), !name.isEmpty {
            self.presenter?.selectCategory(name.lowercased())
            self.listTableView.backgroundView = loadTableIndicator
            self.loadTableIndicator.startAnimating()
        }
        
    }
    
}


extension ListViewController:  ListPresenterToViewProtocol {
    
    func setupUI() {
        self.title = "News"
        
        view.addSubviews(
            textField,
            listTableView,
            loadMoreIndiator
        )
        
        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(64)
        }
        
        listTableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        loadMoreIndiator.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-32)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    func getCategories() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func getArticles() {
        DispatchQueue.main.async { [weak self] in
            self?.listTableView.reloadData()
            self?.loadTableIndicator.stopAnimating()
            self?.loadMoreIndiator.stopAnimating()
        }
    }
    
    func getArticlesError(message: String?) {
        self.view.makeToast(message)
    }
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = presenter?.data.count, count - 1 == indexPath.row, count < (presenter?.totalCounts ?? 0)  {
            loadMoreIndiator.startAnimating()
            self.presenter?.loadMore()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = presenter?.data[indexPath.row] {
            presenter?.goToDetail(index: indexPath.row, source: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! ListCell
        if let item = presenter?.data[indexPath.row] {
            cell.bind(item: item)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.data.count ?? 0
    }
}

extension ListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.categories.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.categories[row].name.capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let name =  presenter?.categories[row].name {
            self.textField.text = name.capitalized
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
}

