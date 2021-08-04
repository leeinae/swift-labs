//
//  CustomCalendarCell.swift
//  calendar-labs
//
//  Created by inae Lee on 2021/08/04.
//

import FSCalendar
import UIKit

class CustomCalendarCell: FSCalendarCell {
    let iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "habbit5")

        return iconImage
    }()
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.insertSubview(iconImage, at: 0)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.frame = contentView.frame
    }
}
