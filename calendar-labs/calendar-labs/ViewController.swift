//
//  ViewController.swift
//  calendar-labs
//
//  Created by inae Lee on 2021/08/04.
//

import FSCalendar
import SnapKit
import UIKit

class ViewController: UIViewController {
    let calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
    }

    func setConstraints() {
        view.addSubview(calendar)

        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}
