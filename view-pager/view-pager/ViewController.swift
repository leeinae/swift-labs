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
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private var menuIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange

        return view
    }()

    private lazy var sectionCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .right)

        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    var selectedIdx = 0
    var label = UILabel()

    let menu = ["profile", "job", "weather"]
    let subViewControllers: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setConstraint()
    }

    func setCollectionView() {
        collectionView(menuCollectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
    }

    func setConstraint() {
        let views: [UIView] = [menuCollectionView, menuIndicatorView, sectionCollectionView]
        views.forEach { v in
            view.addSubview(v)
        }

        let labelSize = calcLabelSize(text: menu[0])
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(labelSize.height + 20)
        }

        menuIndicatorView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom)
            make.width.equalTo(labelSize.width + 30)
            make.height.equalTo(5)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        }

        sectionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuIndicatorView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func wrapAndGetCell(viewColtroller: UIViewController, cell: SectionCollectionViewCell) -> SectionCollectionViewCell {
        viewColtroller.view.tag = SectionCollectionViewCell.SUBVIEW_TAG
        cell.contentView.addSubview(viewColtroller.view)

        /// 다른 UIViewController, PageViewController 등의 컨테이너 뷰컨에서 다른 UIViewController가 추가, 삭제된 후에 호출된다.
        /// 인자로 부모 뷰컨을 넣어서 호출해줌..
        /// 자식 뷰컨이 부모 뷰컨으로부터 추가, 삭제되는 상황에 반응할 수 있도록.
        viewColtroller.didMove(toParent: self)
        return cell
    }

    func calcLabelSize(text: String) -> CGSize {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        return label.bounds.size
    }

    func scrollToMenu(to index: Int) {
        menuCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .right)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == menuCollectionView {
            return 20
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == menuCollectionView {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = menu[indexPath.row]
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.sizeToFit()

        if collectionView == menuCollectionView {
            return CGSize(width: label.bounds.width + 30, height: label.bounds.height + 20)
        }
        let height = UIScreen.main.bounds.height - (menuCollectionView.contentSize.height + 5)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return menu.count
        }
        return subViewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case menuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }

            if indexPath.row == 0 {
                cell.isSelected = true
                menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
            } else {
                cell.isSelected = false
            }

            cell.setCell(menu: menu[indexPath.row])
            return cell
        case sectionCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as? SectionCollectionViewCell else { return UICollectionViewCell() }
            let sectionVC = subViewControllers[indexPath.row]
            print(cell, "✏️")

            return wrapAndGetCell(viewColtroller: sectionVC, cell: cell)
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            let rect = sectionCollectionView.layoutAttributesForItem(at: indexPath)?.frame
            sectionCollectionView.scrollRectToVisible(rect!, animated: false)

//            sectionCollectionView.contentSize = CGSize(width: sectionCollectionView.bounds.width * CGFloat(subViewControllers.count), height: sectionCollectionView.bounds.height)
//            sectionCollectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: .left, animated: false)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        scrollToMenu(to: idx)
    }
}
