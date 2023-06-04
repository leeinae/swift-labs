//
//  DELETE.swift
//  ribs-labs
//
//  Created by inae Lee on 2023/06/03.
//

import RIBs

protocol LoggedOutDependency {}

protocol LoggedOutListener {}

protocol LoggedOutBuildable {
    func build(withListener: LoggedOutListener) -> ViewableRouting
}

class LoggedOutInteractor: Interactor {}

class LoggedOutViewController: UIViewController, ViewControllable {}

class LoggedOutBuilder: LoggedOutBuildable {
    init(dependency: Any) {}

    func build(withListener: LoggedOutListener) -> ViewableRouting {
        ViewableRouter<Interactable, ViewControllable>(
            interactor: LoggedOutInteractor(),
            viewController: LoggedOutViewController()
        )
    }
}
