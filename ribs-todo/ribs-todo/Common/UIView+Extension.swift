//
//  UIView+Extension.swift
//  ribs-todo
//
//  Created by Inae Lee on 2023/06/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
