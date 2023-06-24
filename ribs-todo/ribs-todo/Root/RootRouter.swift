//
//  RootRouter.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss()
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loggedOutBuilder: LoggedOutBuildable,
        loggedInBuilder: LoggedInBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToLoggedOut()
    }

    func routeToLoggedIn(username: String?) {
        if let loggedOutRouter {
            detachChild(loggedOutRouter)
            self.loggedOutRouter = nil
            viewController.dismiss()
        }

        let router = loggedInBuilder.build(withListener: interactor)
        attachChild(router)
    }

    // MARK: - Private

    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouter: LoggedOutRouting?

    private let loggedInBuilder: LoggedInBuildable
    private var loggedInRouter: LoggedOutRouting?

    private func routeToLoggedOut() {
        let router = loggedOutBuilder.build(withListener: interactor)
        loggedOutRouter = router
        attachChild(router)
        viewController.present(viewController: router.viewControllable)
    }
}
