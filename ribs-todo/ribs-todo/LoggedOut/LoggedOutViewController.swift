//
//  LoggedOutViewController.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs
import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    func signIn(username: String?, password: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    weak var listener: LoggedOutPresentableListener?

    init() {
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([usernameTextField, passwordTextField, confirmButton])

        usernameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(30)
            make.centerX.height.equalTo(usernameTextField)
        }

        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(passwordTextField)
            make.bottom.equalToSuperview().inset(300)
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(50)
        }
    }

    private func bind() {
        confirmButton.rx.tap
            .subscribe { [weak self] _ in
                guard let self else { return }

                self.listener?.signIn(
                    username: usernameTextField.text,
                    password: passwordTextField.text
                )
            }
            .disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()

    // MARK: - UI Component

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "user name"
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        return textField
    }()

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
}
