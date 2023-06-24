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

    // MARK: - Private

    private func setupUI() {
        view.backgroundColor = .orange
    }
}
