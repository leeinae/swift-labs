//
//  ViewController.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs
import UIKit

protocol RootPresentableListener: AnyObject {
    /// viewController가 비즈니스 로직 수행을 위해 호출할 수 있는 함수, property 등을 정의하는 프로토콜
    /// interactor에 의해 구현됨
}

final class RootViewController: UIViewController, RootPresentable {
    weak var listener: RootPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension RootViewController: RootViewControllable {
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true)
    }

    func dismiss(viewController: ViewControllable) {
        if presentedViewController == viewController.uiviewController {
            dismiss(animated: true)
        }
    }
}

extension RootViewController: LoggedInViewControllable {

}
