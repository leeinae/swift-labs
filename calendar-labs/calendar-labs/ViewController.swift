//
//  ViewController.swift
//  calendar-labs
//
//  Created by inae Lee on 2021/08/04.
//

import FSCalendar
import SnapKit
import UIKit

class ViewController: UIViewController {
    let calendar = FSCalendar()

    let prevButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(didTapPrevButton(_:)), for: .touchUpInside)

        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)

        return button
    }()

    lazy var calendarHeaderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    lazy var dateFormatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ko_KR")
        dateformatter.dateFormat = "M월\nyyyy"

        return dateformatter
    }()

    var currPage = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        setCalendar()
        setConstraints()
    }

    // MARK: - Actions

    @objc
    func didTapNextButton(_ sender: UIButton) {
        didChangeCalendarPage(at: 1)
    }

    @objc
    func didTapPrevButton(_ sender: UIButton) {
        didChangeCalendarPage(at: -1)
    }

    // MARK: - Methods

    func didChangeCalendarPage(at page: Int) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = page

        currPage = cal.date(byAdding: dateComponents, to: currPage) ?? Date()
        calendar.setCurrentPage(currPage, animated: true)
    }

    func setCalendar() {
        calendar.scope = .month
        calendar.dataSource = self
        calendar.delegate = self

        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: String(describing: CustomCalendarCell.self))

        /// 요일 한글 변환
        calendar.locale = Locale(identifier: "ko_KR")

        /// 날짜 선택
        calendar.allowsMultipleSelection = true
        calendar.allowsSelection = true

        /// textColor
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.todayColor = .purple
        calendar.appearance.headerTitleColor = .black

        /// hide top, bottom border
        calendar.clipsToBounds = true

        calendar.today = nil /// 오늘 표시 숨기기

        /// Header
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 25)
        calendar.appearance.headerDateFormat = "M월 YYYY년"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 0

        calendarHeaderLabel.text = dateFormatter.string(from: calendar.currentPage)
    }

    func setConstraints() {
        [nextButton, prevButton, calendarHeaderLabel, calendar].forEach { component in
            view.addSubview(component)
        }

        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(calendarHeaderLabel.snp.trailing).offset(20)
            make.centerY.equalTo(calendarHeaderLabel.snp.centerY)
        }

        prevButton.snp.makeConstraints { make in
            make.trailing.equalTo(calendarHeaderLabel.snp.leading).offset(-20)
            make.centerY.equalTo(calendarHeaderLabel.snp.centerY)
        }

        calendarHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.centerX.equalToSuperview()
        }

        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarHeaderLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(300)
        }
    }

    func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let customCell = cell as? CustomCalendarCell else { return }

        customCell.iconImage.isHidden = !Calendar(identifier: .gregorian).isDate(date, inSameDayAs: Date())
        customCell.titleLabel.isHidden = Calendar(identifier: .gregorian).isDate(date, inSameDayAs: Date())
    }
}

/// 날짜 아래 이미지 띄우기
extension ViewController: FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        UIImage(named: "habbit5")
//    }
}

extension ViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        CGPoint(x: .zero, y: -5)
    }
}

extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(calendar.selectedDate)
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: String(describing: CustomCalendarCell.self), for: date, at: position)

        return cell
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        configure(cell: cell, for: date, at: monthPosition)
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        calendarHeaderLabel.text = dateFormatter.string(from: calendar.currentPage)
    }
}
