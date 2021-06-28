//
//  ViewController.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var menuCollectionView: UICollectionView!

    let menu = ["profile", "job", "weather"]

    override func viewDidLoad() {
        super.viewDidLoad()

        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
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
        let label = UILabel()
        label.text = menu[indexPath.row]
        label.sizeToFit()

        return CGSize(width: label.bounds.width + 30, height: label.bounds.height + 10)
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
}
