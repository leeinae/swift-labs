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
        
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    }
    
    func setCell(idx: Int) {
        contentView.backgroundColor = .blue
        
        label.text = "\(idx) 번째"
    }
    
    // MARK: - Protocols
}
