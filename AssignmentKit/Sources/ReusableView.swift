//
//  ReusableView.swift
//  AssignmentKit
//
//  Created by yepz on 05/03/23.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }

public extension UITableView {
    func registerCells(_ cellClasses: UITableViewCell.Type...) {
        for type in cellClasses {
            register(type, forCellReuseIdentifier: type.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}
