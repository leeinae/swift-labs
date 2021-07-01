//
//  RecycleViewController.swift
//  floating-tabbar
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

class RecycleViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recycle"
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .systemRed

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
