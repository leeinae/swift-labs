//
//  PageViewController.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

URLSession

class PageViewController: UIPageViewController {
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black

        return view
    }()

    var menuSize: CGSize = {
        let label = UILabel()
        label.text = "pro"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        return label.bounds.size
    }()

    let subViewControllers: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        dataSource = self

        setConstraint()
    }

    func setConstraint() {
        view.addSubview(dividerView)

        dividerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(20)
            make.width.equalTo(self.menuSize.width + 30)
            make.height.equalTo(5)
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = subViewControllers.firstIndex(of: viewController) else { return nil }

        let nextIndex = index + 1

        if nextIndex == subViewControllers.count { return nil }

        return subViewControllers[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = subViewControllers.firstIndex(of: viewController) else { return nil }

        let previousIndex = index - 1

        if previousIndex < 0 { return nil }

        return subViewControllers[previousIndex]
    }
}
