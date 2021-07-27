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

        requestSendNotification(seconds: 3)
    }

    /// 알림 전송
    func requestSendNotification(seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Apple Push Notification ❤️‍🔥"
        content.body = "드디어 푸시 알림을 해보는 .. 그런거죠"
        content.userInfo = ["targetScene": "splash"]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error = error {
                print(#function, error)
            }
        }
    }
}
