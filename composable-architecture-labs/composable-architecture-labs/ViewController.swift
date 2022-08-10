//
//  ViewController.swift
//  composable-architecture-labs
//
//  Created by Devsisters on 2022/08/10.
//

import SnapKit
import Then
import UIKit

class ViewController: UIViewController {
    let plusButton = UIButton(type: .system).then {
        $0.setTitle("+", for: .normal)
        $0.backgroundColor = .systemGray5
    }

    let minusButton = UIButton(type: .system).then {
        $0.setTitle("-", for: .normal)
        $0.backgroundColor = .systemGray5
    }

    let resultLabel = UILabel().then {
        $0.text = "0"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        [plusButton, minusButton, resultLabel].forEach { view.addSubview($0) }

        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        plusButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
            make.size.equalTo(44)
        }

        minusButton.snp.makeConstraints { make in
            make.top.equalTo(plusButton.snp.top)
            make.trailing.equalToSuperview().inset(40)
            make.size.equalTo(44)
        }
    }
}
