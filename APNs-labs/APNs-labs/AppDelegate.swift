//
//  AppDelegate.swift
//  APNs-labs
//
//  Created by inae Lee on 2021/07/27.
//

import Firebase
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let notificationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])

        /// 알람 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { _, error in
            if let error = error {
                print(#function, error)
            }
        }
        application.registerForRemoteNotifications()
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    /// foreground 상태일 때 push 알림 받음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo, "👅")
        
        /// 애널리틱스에 전달
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler([.list, .badge, .sound, .banner])
    }

    /// background일 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber += 1

        let userInfo = response.notification.request.content.userInfo
        print(userInfo, "👅")
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    /// 메시지 대리자 설정
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching")
    }

    /// 현재 등록 토큰 가져오기 (갱신 시 알림 받기)
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print(fcmToken, "🥺")

        /// 서버로 토큰 등록
//        let dataDict: [String: String] = ["token": fcmToken ?? ""]
//        NotificationCenter.default.post(
//            name: Notification.Name("FCMToken"),
//            object: nil,
//            userInfo: dataDict
//        )
    }

    /// 앱이 백그라운드에 있는 동안 notification을 수신하는 경우, 사용자가 알림을 탭해 앱을 런칭할때까지 이 콜백이 실행되지 않음.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo, "💬")
        Messaging.messaging().appDidReceiveMessage(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }

    /// @apnsToken: application delegate로부터 받은 APNs Token을 설정하는데 사용됨.
    /// FIRM 메시징은 method swizzling을 사용해 APNs Token이 자동으로 설정되도록 함. FirebaseAppDelegateProxyEnabled를 NO로 설정한 경우 swizzling을 허용하지 않는 경우 해당 메소드에서 APNs Token을 수동으로 설정한다.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}
