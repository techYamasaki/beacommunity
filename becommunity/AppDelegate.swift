//
//  AppDelegate.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/09/07.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NCMB.initialize(applicationKey: "key", clientKey: "key");
//        // クラスのNCMBObjectを作成
//        let object : NCMBObject = NCMBObject(className: "message")
//        // オブジェクトに値を設定
//        object["age"] = 10
//        object["appearance"] = "test"
//        // データストアへの登録
//        object.saveInBackground(callback: { result in
//            switch result {
//
//            case .success:
//                // 保存に成功した場合の処理
//                print("保存に成功しました")
//            case let .failure(error):
//                // 保存に失敗した場合の処理
//                print("保存に失敗しました: \(error)")
//            }
//        })
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

