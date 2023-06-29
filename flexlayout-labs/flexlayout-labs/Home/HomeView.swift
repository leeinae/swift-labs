//
//  HomeView.swift
//  flexlayout-labs
//
//  Created by Inae Lee on 2023/06/28.
//

import FlexLayout
import UIKit

class HomeView: UIView {
    init() {
        super.init(frame: .zero)
        setupUI()
        define()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all(pin.safeArea)
        containerView.flex.layout()
    }

    // MARK: - Private

    private let data: [(Bool, UIColor)] = [
        (false, .init(rgb: 0xF3D2AC)),
        (true, .init(rgb: 0x9AB0C9)),
        (false, .init(rgb: 0x838589)),
        (true, .init(rgb: 0x676767)),
        (false, .init(rgb: 0xC5D9E9)),
        (true, .init(rgb: 0xCCC5E9)),
        (true, .init(rgb: 0x9AC1C9)),
        (false, .init(rgb: 0xC9B29A))
    ]

    private func define() {
        containerView.flex
            .padding(20)
            .define { flex in
                /// header
                flex.addItem().direction(.row)
                    .height(50)
                    .alignItems(.center)
                    .define { flex in
                        flex.addItem(nameLabel).marginRight(10)
                        flex.addItem(iconButton).padding(4, 6)
                        flex.addItem().grow(1)
                        flex.addItem(profileImageView).size(40)
                    }

                /// collectionView
                flex.addItem(collectionView).grow(1).marginTop(10)
            }
    }

    private func setupUI() {
        backgroundColor = .white
        addSubview(containerView)
    }

    // MARK: - UI Component

    private let containerView = UIView()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "내 이름"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let iconButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이콘", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "figure.wave")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .init(rgb: 0x838589)
        return imageView
    }()

    fileprivate let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            ItemCell.self,
            forCellWithReuseIdentifier: ItemCell.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCell.identifier,
            for: indexPath
        ) as? ItemCell else { return UICollectionViewCell() }
        let (isHidden, color) = data[indexPath.row]
        cell.configure(isHidden: isHidden, color: color)

        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ItemCell.identifier,
            for: indexPath
        ) as? ItemCell else { return .zero }

        let (isHidden, color) = data[indexPath.row]
        cell.configure(isHidden: isHidden, color: color)
//        return cell.sizeThatFits(.init(width: collectionView.bounds.width, height: .greatestFiniteMagnitude))
        return cell.fittedSize(width: collectionView.bounds.width)
    }
}
