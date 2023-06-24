//
//  TodoViewController.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs
import RxSwift
import UIKit

protocol TodoPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TodoViewController: UIViewController, TodoPresentable, TodoViewControllable {
    weak var listener: TodoPresentableListener?

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private

    private let username: String

    // MARK: - UI Component

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.username)의 Todo"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .gray
        return label
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([usernameLabel, addButton, tableView])

        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().inset(24)
        }

        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(usernameLabel)
            make.trailing.equalToSuperview().inset(24)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
