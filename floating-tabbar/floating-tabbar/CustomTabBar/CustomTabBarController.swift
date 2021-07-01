//
//  CustomTabBarController.swift
//  floating-tabbar
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

class CustomTabBarController: UITabBarController {
    // MARK: - UIComponenets

    // MARK: - Properties

    private let tabBarItems: [String] = ["house", "arrow.3.trianglepath", "bolt.circle", "folder"]
    lazy var floatingTabbarView = FloatingBarView(tabBarItems)

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
        setupFloatingTabBar()
    }

    // MARK: - Actions

    // MARK: - Methods

    private func createNavViewController(viewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true

        return navigationController
    }

    func setTabBarController() {
        viewControllers = [createNavViewController(viewController: HomeViewController()), createNavViewController(viewController: RecycleViewController()), createNavViewController(viewController: StorageViewController()), createNavViewController(viewController: SettingViewController())]

        tabBar.isHidden = true
    }

    func setupFloatingTabBar() {
        floatingTabbarView.delegate = self

        view.addSubview(floatingTabbarView)
        floatingTabbarView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(37)
            make.bottom.equalToSuperview().offset(-34)
        }
    }

    // MARK: - Protocols
}

extension CustomTabBarController: FloatingBarViewDelegate {
    func didTapBarItem(selectindex: Int) {
        selectedIndex = selectindex
    }
}
