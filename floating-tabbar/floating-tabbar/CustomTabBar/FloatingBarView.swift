//
//  FloatingBarView.swift
//  floating-tabbar
//
//  Created by inae Lee on 2021/07/01.
//

import SnapKit
import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func didTapBarItem(selectindex: Int)
}

class FloatingBarView: UIView {
    // MARK: - UIComponenets

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        return stackView
    }()

    // MARK: - Properties

    var buttons: [UIButton] = []
    weak var delegate: FloatingBarViewDelegate?
    var iconSize = (48 * UIScreen.main.bounds.width) / 375

    // MARK: - Initializer

    init(_ items: [String]) {
        super.init(frame: .zero)
        backgroundColor = .white

        setupStackView(items)
        updateUI(selectedIndex: 0)
        setContraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 16
    }

    // MARK: - Actions

    @objc
    func changeTab(_ sender: UIButton) {
        delegate?.didTapBarItem(selectindex: sender.tag)
        updateUI(selectedIndex: sender.tag)
    }

    // MARK: - Methods

    func setupStackView(_ items: [String]) {
        for (index, item) in items.enumerated() {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
            let normalImage = UIImage(systemName: item, withConfiguration: symbolConfig)
            let selectedImage = UIImage(systemName: item, withConfiguration: symbolConfig)
            let button = createButton(normalImage: normalImage!, selectedImage: selectedImage!, index: index)
            buttons.append(button)
        }
    }

    func createButton(normalImage: UIImage, selectedImage: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tag = index
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)

        button.snp.makeConstraints { make in
            make.width.height.equalTo(iconSize)
        }
        return button
    }

    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
                button.tintColor = .systemBlue
            } else {
                button.isSelected = false
                button.tintColor = .gray
            }
        }
    }

    func setContraint() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(18)
        }
    }

    // MARK: - Protocols
}
