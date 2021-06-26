//
//  CardCollectionView.swift
//  slide-card
//
//  Created by inae Lee on 2021/06/27.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static let identifier = "CardCollectionViewCell"

    // MARK: - UIComponenets

    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initCell()
        setConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [label].forEach { v in
            contentView.addSubview(v)
        }
        
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setCell(idx: Int) {
        label.text = "\(idx + 1) 번째"
    }
    
    func initCell() {
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
    }

    // MARK: - Protocols
}
