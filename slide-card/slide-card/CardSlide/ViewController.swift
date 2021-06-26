//
//  ViewController.swift
//  slide-card
//
//  Created by inae Lee on 2021/06/26.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UIComponenets

    private let label: UILabel = {
        let label = UILabel()
        label.text = "📬 Card Silde!"

        return label
    }()

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.5)

        return layout
    }()

    private lazy var
        collectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collectionView.backgroundColor = .white

            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.decelerationRate = .fast

            collectionView.delegate = self
            collectionView.dataSource = self

            return collectionView
        }()

    // MARK: - Properties

    let cardSize = CGSize(width: 300, height: 500)

    // MARK: - Initializer

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        setCollectionView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        [label, collectionView].forEach { v in
            view.addSubview(v)
        }

        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true

        collectionView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func setCollectionView() {
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
    }

    // MARK: - Protocols
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = view.frame.width * 0.2 / 2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cardSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        view.frame.width * 0.2 / 2
    }

    /// velocity - 스크롤하다 터치 해제 시 속도
    /// targetContentOffset - 스크롤 속도가 줄어들어 정지될 때 예상되는 위치
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let spacing = cardSize.width + (view.frame.width * 0.2 / 2)
        var offset = targetContentOffset.pointee
        let index = round((offset.x + scrollView.contentInset.left) / spacing)

        offset = CGPoint(x: index * spacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCell(idx: indexPath.row)

        return cell
    }
}
