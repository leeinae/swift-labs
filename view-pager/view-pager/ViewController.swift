//
//  ViewController.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import SnapKit
import UIKit

enum menuStatus: Int {
    case profile = 0
    case job = 1
    case weather = 2
}

class ViewController: UIViewController {
    private lazy var menuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white

        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private var menuDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange

        return view
    }()

    private let pageViewController: PageViewController = {
        let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)

        return pageViewController
    }()

    var selectedIdx = 0
    var menuSize: CGSize = {
        let label = UILabel()
        label.text = "pro"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        return label.bounds.size
    }()

    let menu = ["profile", "job", "weather"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
    }

    func setConstraint() {
        let views: [UIView] = [menuCollectionView, menuDividerView, pageViewController.view]
        views.forEach { v in
            view.addSubview(v)
        }

        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.menuSize.height + 20)
        }

        menuDividerView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom)
            make.width.equalTo(self.menuSize.width + 30)
            make.height.equalTo(5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }

        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(menuDividerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: menuSize.width + 30, height: menuSize.height + 20)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }

        cell.setCell(menu: menu[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        pageViewController.current
    }
}
