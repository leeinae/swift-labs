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
        layout.itemSize = CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.8)

        return layout
    }()

    private lazy var
        collectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.decelerationRate = .fast
            collectionView.backgroundColor = .black

            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

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

    // MARK: - Protocols
}

extension ViewController: UICollectionViewDelegateFlowLayout {}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
