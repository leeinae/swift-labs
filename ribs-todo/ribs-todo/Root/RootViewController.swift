//
//  RootViewController.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    weak var listener: RootPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}

// MARK: - LoggedInViewControllable

extension RootViewController: LoggedInViewControllable {}
