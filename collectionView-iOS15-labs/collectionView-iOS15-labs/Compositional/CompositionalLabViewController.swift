//
//  CompositionalLabViewController.swift
//  collectionView-iOS15-labs
//
//  Created by Devsisters on 2022/07/21.
//

import SnapKit
import Then
import UIKit

enum CustomSection {
    case first([FirstItem])
    case second([SecondItem])

    struct FirstItem {
        let value: String
    }

    struct SecondItem {
        let value: String
    }
}

class CompositionalLabViewController: UIViewController {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout).then {
        $0.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ColorCollectionViewCell.self))
        $0.dataSource = self
    }

    // MARK: - Properties

    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemFractionalWidthFraction = 1.0 / 3.0
        let groupFractionalWidthFaction = 1.0 / 4.0

        let itemInset = 2.5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidthFraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(groupFractionalWidthFaction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        return UICollectionViewCompositionalLayout(section: section)
    }()

    private let dataSource: [CustomSection] = [
        .first((1 ... 30).map(String.init).map(CustomSection.FirstItem.init(value:))),
        .second((31 ... 60).map(String.init).map(CustomSection.SecondItem.init(value:))),
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CompositionalLabViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case let .first(items): return items.count
        case let .second(items): return items.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCollectionViewCell.self), for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }

        switch dataSource[indexPath.section] {
        case let .first(items):
            cell.config(text: items[indexPath.row].value)
        case let .second(items):
            cell.config(text: items[indexPath.row].value)
        }

        return cell
    }
}
