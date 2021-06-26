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
        label.text = "웅앵우앵"

        return label
    }()

    // MARK: - Properties

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

        [label].forEach { v in
            view.addSubview(v)
        }

        label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    // MARK: - Protocols
}
