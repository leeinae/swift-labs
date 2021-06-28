//
//  MenuCollectionViewCell.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier = "MenuCollectionViewCell"

    @IBOutlet var menuTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(menu: String) {
        menuTitle.text = menu
        menuTitle.sizeToFit()

        menuTitle.font = .systemFont(ofSize: 18)
    }
}
