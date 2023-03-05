import UIKit

public extension UIStackView {
    func addMultipleArrangeSubviews(_ view: UIView...) {
        view.forEach {
            self.addArrangedSubview($0)
        }
    }

    func addMultipleArrangeSubviews(_ view: [UIView]) {
        view.forEach {
            self.addArrangedSubview($0)
        }
    }
}
