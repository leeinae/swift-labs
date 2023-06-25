//
//  DetailTodoViewController.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/25.
//

import RIBs
import RxSwift
import UIKit

protocol DetailTodoPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailTodoViewController: UIViewController, DetailTodoPresentable, DetailTodoViewControllable {
    weak var listener: DetailTodoPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func set(todo: TodoModel) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.description
    }

    // MARK: - UI Component

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubviews([titleLabel, descriptionLabel])
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.trailing.equalToSuperview().inset(12)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
}
