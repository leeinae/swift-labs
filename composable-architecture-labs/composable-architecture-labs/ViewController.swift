//
//  ViewController.swift
//  composable-architecture-labs
//
//  Created by Devsisters on 2022/08/10.
//

import Combine
import ComposableArchitecture
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

struct CounterState: Equatable {
    let id = UUID()
    var count = 0
}

enum CounterAction {
    case plus
    case minus
}

struct CounterEnvironment {}

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

    private let viewStore: ViewStore<CounterState, CounterAction>
    private var cancellables: Set<AnyCancellable> = []
    private let disposeBag = DisposeBag()

    init(store: Store<CounterState, CounterAction>) {
        viewStore = .init(store)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }

    private func setupUI() {
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

    private func bind() {
        /// Action
        plusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewStore.send(.plus)
            })
            .disposed(by: disposeBag)

        minusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewStore.send(.minus)
            })
            .disposed(by: disposeBag)

        /// Effect ?
        viewStore.publisher
            .map { "\($0.count)" }
            .assign(to: \.text, on: resultLabel)
            .store(in: &cancellables)
    }
}
