//
//  ViewController.swift
//  flexlayout-labs
//
//  Created by inae Lee on 2023/06/20.
//

import FlexLayout
import PinLayout
import UIKit

class ViewController: UIViewController {
    private let flexContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        return view
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Intro", "FlexLayout", "PinLayout"])
        control.selectedSegmentIndex = 0
        return control
    }()

    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Flexbox layouting is simple, powerfull and fast.\n\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0
        return label
    }()

    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "FlexLayout/yoga is incredibly fast, its even faster than manual layout."
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        flexContainer.pin.all(view.pin.safeArea)
        flexContainer.flex.layout()
    }

    private func setupUI() {
        view.addSubview(flexContainer)

        flexContainer.flex
            .padding(12)
            .alignItems(.start)
            .define { flex in
                flex.addItem()
                    .direction(.row)
                    .alignSelf(.end)
                    .define { flex in
                        flex.addItem(imageView)
                            .size(100)
                            .aspectRatio(of: imageView)

                        let colorView = UIView()
                        colorView.backgroundColor = .systemMint
                        flex.addItem(colorView)
                            .size(100)
                    }
            }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            self?.imageView.flex.isIncludedInLayout(false)
            self?.imageView.flex.markDirty()

            self?.flexContainer.flex.layout()
        }
    }
}
