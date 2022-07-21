//
//  ColorCollectionViewCell.swift
//  collectionView-iOS15-labs
//
//  Created by Devsisters on 2022/07/21.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let titleLabel: UILabel = .init()

    func config(text: String) {
        titleLabel.text = text
    }

    func setupUI() {
        backgroundColor = .magenta
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
