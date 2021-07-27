//
//  ViewController.swift
//  APNs-labs
//
//  Created by inae Lee on 2021/07/27.
//

import UIKit

class ViewController: UIViewController {
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestSendNotification(seconds: 3)
        addTimeTrigger()
        addDateTimeTrigger()
    }

    /// 알림 전송
    func requestSendNotification(seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Apple Push Notification ❤️‍🔥"
        content.subtitle = "우와!"
        content.body = "드디어 푸시 알림을 해보는 .. 그런거죠"
        content.userInfo = ["targetScene": "splash"]
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print(#function, error)
            }
        }
    }

    /// 1분마다 오는 알림 트리거 추가
    func addTimeTrigger() {
        let dateContent = UNMutableNotificationContent()
        dateContent.title = "정신 차리기!"
        dateContent.body = "혹시 할 일을 미루고 있지는 않나요? 🤔"
        dateContent.sound = UNNotificationSound.default
        dateContent.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "WATER", content: dateContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func addDateTimeTrigger() {
        let dateContent = UNMutableNotificationContent()

        dateContent.title = "꼴깍"
        dateContent.subtitle = "물 마시기"
        dateContent.body = "매일 1시 30분! 물 마실 시간이에요 💦"
        dateContent.sound = UNNotificationSound.default
        dateContent.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 1
        dateComponents.minute = 30

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: dateContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
