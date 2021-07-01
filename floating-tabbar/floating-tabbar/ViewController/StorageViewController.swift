//
//  StorageViewController.swift
//  floating-tabbar
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

class StorageViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Storage"
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .systemGreen

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
