//
//  ItemCell.swift
//  flexlayout-labs
//
//  Created by Inae Lee on 2023/06/28.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    static let identifier = String(describing: ItemCell.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        define()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(isHidden: Bool, color: UIColor) {
        delayButton.flex.isIncludedInLayout(!isHidden).markDirty()
        contentView.backgroundColor = color

        setNeedsLayout()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()

        return contentView.frame.size
    }

    func fittedSize(width: CGFloat) -> CGSize {
        contentView.pin.width(width)
        layout()

        return contentView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    // MARK: - Private

    private func define() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .gray

        contentView.flex.padding(20)
            .define { flex in
                /// top
                flex.addItem().direction(.row)
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(mainIconImageView).size(30).marginRight(10)
                        flex.addItem()
                            .define { flex in
                                flex.addItem(titleLabel)
                                flex.addItem(descriptionLabel).marginTop(6)
                            }
                            .grow(1)
                    }

                /// button
                flex.addItem(delayButton).padding(2, 4).alignSelf(.end)
            }
    }

    private func layout() {
        contentView.flex.layout(mode: .adjustHeight)
    }

    // MARK: - UI Component

    private let mainIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")?.withTintColor(.init(rgb: 0xD49BA7), renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 15
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 할 일"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "📌 숨 셔 .."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let delayButton: UIButton = {
        let button = UIButton()
        button.setTitle("✅ 완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .darkGray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
}
