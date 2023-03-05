//
//  ListCell.swift
//  Assignment
//
//  Created by yepz on 05/03/23.
//

import Foundation
import UIKit
import AssignmentKit

class ListCell: UITableViewCell {
    
    private lazy var sourceLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .bold)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.numberOfLines = 0
    }
    
    private lazy var divider = UIView().then {
        $0.backgroundColor = .lightGray
        $0.alpha = 0.6
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    private lazy var stack = VStack {
        sourceLabel
        titleLabel
    }.setSpacing(8)
    
    
    private lazy var wrapView = UIView().then {
        $0.addSubview(stack)
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(8)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(wrapView, divider)
        wrapView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        divider.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(wrapView)
        }
    }
   
    func bind(item: ArticleModel) {
        self.titleLabel.text = item.title
        self.sourceLabel.text = item.source?.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
