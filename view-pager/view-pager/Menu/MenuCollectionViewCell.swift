//
//  MenuCollectionViewCell.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"

    private let menuTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)

        return label
    }()

    override var isSelected: Bool {
        willSet {
            if newValue {
                menuTitle.textColor = .black
            } else {
                menuTitle.textColor = .lightGray
            }
        }
    }

    override func prepareForReuse() {
        isSelected = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(menuTitle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(menu: String) {
        menuTitle.text = menu
        menuTitle.sizeToFit()

        menuTitle.font = .systemFont(ofSize: 18)
    }

    func setConstraint() {
        menuTitle.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
}
