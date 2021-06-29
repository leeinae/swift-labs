//
//  SectionCollectionViewCell.swift
//  view-pager
//
//  Created by inae Lee on 2021/06/29.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"
    static let SUBVIEW_TAG: Int = 1000

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(view: UIViewController) {}

    /// cell을 재사용할 때 호출한다. 기존에 올라와있던 뷰를 삭제함
    override func prepareForReuse() {
        super.prepareForReuse()

        let subViews = self.contentView.subviews
        for subView in subViews {
            if subView.tag == SectionCollectionViewCell.SUBVIEW_TAG {
                subView.removeFromSuperview()
            }
        }
    }
}
