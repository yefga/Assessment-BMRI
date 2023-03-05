import UIKit

public final class VStack: UIStackView {

    public init(@StackBuilder views: () -> [UIView]) {
        super.init(frame: .zero)
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
        views().forEach { addArrangedSubview($0) }

    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension VStack: StackModifier {
    public func setAlignment(_ alignment: UIStackView.Alignment) -> VStack {
        self.alignment = alignment
        return self
    }

    public func setDistribution(_ distribution: UIStackView.Distribution) -> VStack {
        self.distribution = distribution
        return self
    }

    public func setSpacing(_ spacing: CGFloat) -> VStack {
        self.spacing = spacing
        return self
    }

    public func addArrangedSubviews(_ views: [UIView]) -> VStack {
        addMultipleArrangeSubviews(views)
        return self
    }
}
