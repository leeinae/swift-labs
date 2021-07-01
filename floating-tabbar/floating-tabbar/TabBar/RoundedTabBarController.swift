//
//  RoundedTabBarController.swift
//  floating-tabbar
//
//  Created by inae Lee on 2021/06/27.
//

import UIKit

class RoundedTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = false
        tabBar.backgroundImage = UIImage()
        tabBar.clipsToBounds = false

        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: tabBar.frame.width / 2).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor

        tabBar.layer.insertSublayer(layer, at: 0)

        if let items = tabBar.items {
            items.forEach { item in
                item.image = UIImage(named: "btn")
//                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//                item.image?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 48)
            }
        }

        tabBar.itemWidth = 48.0
        tabBar.itemSpacing = 24
        tabBar.itemPositioning = .centered
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 90
        tabBar.frame.origin.y = view.frame.height - 90
    }
}
