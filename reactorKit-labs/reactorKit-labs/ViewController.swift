//
//  ViewController.swift
//  reactorKit-labs
//
//  Created by Devsisters on 2022/07/08.
//

import RxSwift
import SnapKit
import UIKit

/// https://medium.com/styleshare/reactorkit-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-c7b52fbb131a

class ViewController: UIViewController {
    // MARK: - UI Components

    lazy var followButton: UIButton = {
        let button = UIButton()
        button.configuration = followButtonConfiguration

        return button
    }()

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private var followButtonConfiguration = UIButton.Configuration.filled()

    // MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Configure Methods

    func setupUI() {
        view.backgroundColor = .white
        
        followButtonConfiguration.baseBackgroundColor = .systemBlue

        var titleAttr = AttributedString("Follow Button")
        titleAttr.font = .systemFont(ofSize: 26.0, weight: .heavy)
        followButtonConfiguration.attributedTitle = titleAttr

        view.addSubview(followButton)

        followButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func bind() {}
}
