import UIKit

public final class HStack: UIStackView {

    public init(@StackBuilder views: () -> [UIView]) {
        super.init(frame: .zero)
        axis = .horizontal
        translatesAutoresizingMaskIntoConstraints = false
        views().forEach { addArrangedSubview($0) }

    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension HStack: StackModifier {
    public func setAlignment(_ alignment: UIStackView.Alignment) -> HStack {
        self.alignment = alignment
        return self
    }

    public func setDistribution(_ distribution: UIStackView.Distribution) -> HStack {
        self.distribution = distribution
        return self
    }

    public func setSpacing(_ spacing: CGFloat) -> HStack {
        self.spacing = spacing
        return self
    }

    public func addArrangedSubviews(_ views: [UIView]) -> HStack {
        addMultipleArrangeSubviews(views)
        return self
    }
}
