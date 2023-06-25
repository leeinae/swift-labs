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

    func registerTodo(title: String, description: String)
    func routeToDetailTodo()
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
        bind()
        loadData()
    }

    // MARK: - Private

    private let username: String
    private var data: [String] = []
    private let disposeBag = DisposeBag()

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
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

    private func bind() {
        addButton.rx.tap
            .subscribe { [weak self] _ in
                self?.showAddAlert()
            }
            .disposed(by: disposeBag)
    }

    private func showAddAlert() {
        let alert = UIAlertController(
            title: "Todo",
            message: "할 일을 입력하세요",
            preferredStyle: .alert
        )

        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            let title = textField1.text ?? ""
            let description = textField2.text ?? ""

            self?.tableView.reloadData()
            self?.listener?.registerTodo(title: title, description: description)
            self?.listener?.routeToDetailTodo()
        }

        alert.addTextField { textField in
            textField.placeholder = "todo"
            textField.textColor = .black
        }
        alert.addTextField { textField in
            textField.placeholder = "description"
            textField.textColor = .darkGray
        }
        alert.addAction(cancel)
        alert.addAction(save)
        present(alert, animated: true, completion: nil)
    }

    private func loadData() {
        let todoList = TodoManager.todoList
        data = todoList
    }
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "todoCell",
            for: indexPath
        ) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
}
