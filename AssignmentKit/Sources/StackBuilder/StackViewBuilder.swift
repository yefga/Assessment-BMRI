import UIKit

@resultBuilder
public struct StackBuilder {
    public static func buildBlock(_ views: UIView...) -> [UIView] {
        views
    }
}

public protocol StackModifier {
    associatedtype Stack: UIStackView
    func setAlignment(_ alignment: UIStackView.Alignment) -> Stack
    func setDistribution(_ distribution: UIStackView.Distribution) -> Stack
    func setSpacing(_ spacing: CGFloat) -> Stack
    func addArrangedSubviews(_ views: [UIView]) -> Stack
}
