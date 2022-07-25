//
//  CompositionalLabViewController.swift
//  collectionView-iOS15-labs
//
//  Created by Devsisters on 2022/07/21.
//

import SnapKit
import Then
import UIKit

enum CustomSection: CaseIterable {
    case first, second
}

class CompositionalLabViewController: UIViewController {
    private var collectionView: UICollectionView!

    // MARK: - Properties

    var dataSource: UICollectionViewDiffableDataSource<CustomSection, Int>!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupDataSource()

        setupUI()
    }

    func setupUI() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupCollectionView() {
        collectionView = .init(frame: .zero, collectionViewLayout: generateCollectionViewLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ColorCollectionViewCell.self))
    }

    func setupDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier -> UICollectionViewCell in
            let sectionType = CustomSection.allCases[indexPath.section]

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCollectionViewCell.self), for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }

            switch sectionType {
            case .first:
                cell.backgroundColor = .orange
            case .second:
                cell.backgroundColor = .blue
            }

            cell.config(text: "\(itemIdentifier)")
            return cell
        })

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot)
    }

    func generateCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500

            switch CustomSection.allCases[sectionIndex] {
            case .first: return self.generateFirstLayout(isWide: isWideView)
            case .second: return self.generateSecondLayout()
            }
        }

        return layout
    }

    // MARK: - Layout Methods

    func generateFirstLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupFractionalWidth = 1.0
        let groupFractionalHeight: Float = isWide ? 2.0 / 3.0 : 1.0 / 3.0

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .fractionalHeight(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func generateSecondLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    // MARK: - Snapshot Methods

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<CustomSection, Int> {
        let firstSection = (1 ... 30).map { Int($0) }
        let secondSection = (31 ... 60).map { Int($0) }

        var snapshot = NSDiffableDataSourceSnapshot<CustomSection, Int>()
        snapshot.appendSections(CustomSection.allCases)

        snapshot.appendItems(firstSection, toSection: CustomSection.first)
        snapshot.appendItems(secondSection, toSection: CustomSection.second)

        return snapshot
    }
}

// MARK: - UICollectionViewDelegate

extension CompositionalLabViewController: UICollectionViewDelegate {}

// extension CompositionalLabViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        dataSource.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch dataSource[section] {
//        case let .first(items): return items.count
//        case let .second(items): return items.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCollectionViewCell.self), for: indexPath) as? ColorCollectionViewCell else { return UICollectionViewCell() }
//
//        switch dataSource[indexPath.section] {
//        case let .first(items):
//            cell.config(text: items[indexPath.row].value)
//        case let .second(items):
//            cell.config(text: items[indexPath.row].value)
//        }
//
//        return cell
//    }
// }
