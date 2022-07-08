//
//  ViewController.swift
//  reactorKit-labs
//
//  Created by Devsisters on 2022/07/08.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

/// https://medium.com/styleshare/reactorkit-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-c7b52fbb131a

class ViewController: UIViewController, View {
    typealias Reactor = ViewReactor

    // MARK: - UI Components

    lazy var followButton: UIButton = {
        let button = UIButton()
        button.configuration = followButtonConfiguration
        button.configurationUpdateHandler = followAction

        return button
    }()

    let followAction: UIButton.ConfigurationUpdateHandler = { button in
        switch button.state {
            case .normal:
                button.configuration?.title = "Follow Button"
            case .selected:
                button.configuration?.title = "Unfollow Button"
            default: break
        }
    }

    // MARK: - Properties

    var disposeBag: DisposeBag = .init()
    private let reactor = Reactor()

    private var followButtonConfiguration = UIButton.Configuration.filled()

    // MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind(reactor: reactor)
    }

    // MARK: - Configure Methods

    func setupUI() {
        view.backgroundColor = .white

        var titleAttr = AttributedString()
        titleAttr.font = .systemFont(ofSize: 26.0, weight: .heavy)
        followButtonConfiguration.attributedTitle = titleAttr

        view.addSubview(followButton)

        followButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - Bind Method

    func bind(reactor: ViewReactor) {
        /// input
        followButton.rx.tap
            .scan(false) { lastState, _ in !lastState }
            .map { $0 ? .follow : .unfollow }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        /// output
        reactor.state.map { $0.isFollowing }
            .distinctUntilChanged()
            .bind(to: followButton.rx.isSelected)
            .disposed(by: disposeBag)
    }
}
