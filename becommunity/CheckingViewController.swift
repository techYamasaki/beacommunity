//
//  CheckingViewController.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/09/18.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit
import CoreLocation

class CheckingViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    @IBOutlet weak var receptionTable: UITableView!
    var recepArray: [[String]]! = []/*[["未設定", "status", "detail"]]*/
    // BeaconのUUIDを設定
    let uuid1:UUID? = UUID(uuidString: "uuid")
    //let uuid2:UUID? = UUID(uuidString: "uuid")
    var willApperFirst: Bool!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OK")
        
        receptionTable.delegate = self
        receptionTable.dataSource = self
        
        willApperFirst = true
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.notDetermined) {
            
            self.trackLocationManager.requestAlwaysAuthorization()
            print("OK2")
        }
        
//        // BeaconのUUIDを設定
//        let uuid:UUID? = UUID(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF")
//        let uuid2:UUID? = UUID(uuidString: "48534442-4C46-4144-80C0-1800FFFFFFFF")
        
        
        //Beacon領域を作成
//        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "fabo0")
//        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid2!, identifier: "fabo1")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recepArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receptionCell", for: indexPath)
        cell.textLabel?.text = recepArray[indexPath.row][0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toCheckData", sender: nil)
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCheckData"{
            //detailViewControllerを取得
            //as! DetailViewControllerでダウンキャストしている
            let readingViewController = segue.destination as! ReadingViewController
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = receptionTable.indexPathForSelectedRow!
            readingViewController.checkData = recepArray[selectedIndexPath.row]
            //readingViewController.selectedRow = selectedIndexPath.row
        }
    }
    
    
    //位置認証のステータスが変更された時に呼ばれる
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // 認証のステータス
        var statusStr = ""
        print("CLAuthorizationStatus: \(statusStr)")
        
        // 認証のステータスをチェック
        switch (status) {
        case .notDetermined:
            statusStr = "NotDetermined"
        case .restricted:
            statusStr = "Restricted"
        case .denied:
            statusStr = "Denied"
        //self.status.text   = "位置情報を許可していません"
        case .authorizedAlways:
            statusStr = "Authorized"
        //self.status.text   = "位置情報認証OK"
        default:
            break;
        }
        
        print("CLAuthorizationStatus: \(statusStr)")
        
        //観測を開始させる
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid1!, identifier: "fabo0")
        trackLocationManager.startMonitoring(for: self.beaconRegion)
//        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid2!, identifier: "fabo1")
//        // ディスプレイがOffでもイベントが通知されるように設定(trueにするとディスプレイがOnの時だけ反応).
//        self.beaconRegion.notifyEntryStateOnDisplay = false
//        // 入域通知の設定.
//        self.beaconRegion.notifyOnEntry = true
//        // 退域通知の設定.
//        self.beaconRegion.notifyOnExit = true
//        trackLocationManager.startMonitoring(for: self.beaconRegion)
//
    }
    
    //観測の開始に成功すると呼ばれる
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        self.trackLocationManager.requestState(for: self.beaconRegion)
        trackLocationManager.startRangingBeacons(in: beaconRegion)
        print("didStartMonitoringForRegion")
    }
    
    //領域内にいるかどうかを判定する
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {
        print("didDetermineState:START")
        
        switch (state) {
            
        case .inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
            
            trackLocationManager.startRangingBeacons(in: beaconRegion)
            // →(didRangeBeacons)で測定をはじめる
            break;
            
        case .outside:
            
            // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        case .unknown:
            
            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        default:
            
            break;
            
        }
    }
    
    //領域に入った時
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("ENTER")
        // →(didRangeBeacons)で測定をはじめる
        self.trackLocationManager.startRangingBeacons(in: self.beaconRegion)
        //self.status.text = "didEnterRegion"
        
        //sendLocalNotificationWithMessage("領域に入りました")
    }
    
    //領域から出た時
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("EXIT")
        //測定を停止する
        self.trackLocationManager.stopRangingBeacons(in: self.beaconRegion)
        //reset()
        //sendLocalNotificationWithMessage("領域から出ました")
    }
    
    // 画面が再表示される時
    override func viewWillAppear( _ animated: Bool ) {
        
        super.viewWillAppear( animated )
        
        count1 = 1
        num = 0
        
        recepArray = []
        receptionTable.reloadData()
        print("reranfing2")
        
        if(willApperFirst != true){
            trackLocationManager.startRangingBeacons(in: beaconRegion)
            print("reranfing")
        }
        willApperFirst = false
        
//        if( self.isBeaconRanging == false ) {
//            // Beacon の監視を再開する。
//                        self.locationManager.startRangingBeacons(in: self.beaconRegion);
//                        self.isBeaconRanging = true;
//            print("restart monitoring Beacons")
//        }
    }
    
    // 画面遷移等で非表示になる時
    override func viewWillDisappear( _ animated: Bool ) {
        super.viewDidDisappear( animated )
        self.trackLocationManager.stopRangingBeacons(in: self.beaconRegion)
        print("seeyou")
        title1 = "読み込み中"
        status = "読み込み中"
        detail = "読み込み中です。前画面へ戻ってください。"
        
//        if( self.isBeaconRanging == true ) {
//            // Beacon の監視を停止する
//            self.locationManager.stopRangingBeacons(in: self.beaconRegion);
//            self.isBeaconRanging = false;
//            print("stop monitoring Beacons")
//        }
    }
    
    //    //観測失敗
    //    private func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: Error?) {
    //
    //        print("monitoringDidFailForRegion \(String(describing: error))")
    //
    //    }
    //
    //    //通信失敗
    //    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    //
    //        print("didFailWithError \(error ?? <#default value#>)")
    //
    //    }
    
    var count1: Int = 1
    var count2: Int = 0
    var count3: Int = 0
    var num: Int = 0
    var title1: String = "読み込み中"
    var status: String = "読み込み中"
    var detail: String = "読み込み中です。前画面へ戻ってください。"
    var sex: String = "読み込み中"
    var age: String = "読み込み中"
    var appearance: String = "読み込み中"
    
    


    //領域内にいるので測定をする
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //println(beacons)
        count1 += 1
        print("count1:", count1)
        
        
//        if(beacons.count == 0) { return }
//        //複数あった場合は一番先頭のものを処理する
//        let beacon = beacons[0] as CLBeacon
        
        if(beacons.count > 0){
            //print("count2:", count2)
            count2 += 1
            
            recepArray = []
            receptionTable.reloadData()
            
            for i in 0 ..< beacons.count {
                print()
                let beacon = beacons[i] as CLBeacon
                
                if(beacon.proximity == CLProximity.near || beacon.proximity == CLProximity.immediate){
                    if(beacon.major==1 && beacon.minor==1){
                        recepArray.append(["緊急SOS", "-", "周囲に不審な様子がないか確認してください。", "-", "-", "-"])
                        receptionTable.reloadData()
                        
                    }else if(beacon.major==1 && beacon.minor==2){
                        recepArray.append(["配慮が必要です", "-", "オフライン用メッセージから発信されています。", "-", "-", "-"])
                        receptionTable.reloadData()
                        
                    }else if(beacon.major==1 && beacon.minor==3){
                        recepArray.append(["手助けが必要です", "-", "オフライン用メッセージから発信されています。", "-", "-", "-"])
                        receptionTable.reloadData()
                        
                    }else if(beacon.major==1 && beacon.minor==4){
                        recepArray.append(["意識を失うことがあります。", "-", "オフライン用メッセージから発信されています。", "-", "-", "-"])
                        receptionTable.reloadData()
                        
                    }else if(beacon.major==1 && beacon.minor==5){
                        recepArray.append(["優先席を必要としています。", "-", "オフライン用メッセージから発信されています。", "-", "-", "-"])
                        receptionTable.reloadData()
                        
                    }else if(/*iphone6*/beacon.major==1 && beacon.minor==101/*iphone5*//*beacon.major==1 && beacon.minor==100*/){
                        if(count1 - num != 1){
                            print(count3)
                            count3 += 1
                            //ここから取得
                            let object : NCMBObject = NCMBObject(className: "message")

                            // objectIdプロパティを設定
                            //iphone6
                            object.objectId = "T6VAsoK5gCCJNA9A"
                            //iphone5
                            //object.objectId = "nJ0xRa4PSiFSs3Z4"

                            object.fetchInBackground(callback: { result in
                                switch result {
                                case .success:
                                    // 取得に成功した場合の処理
                                    print("取得に成功しました")
                                    if let titleDataBase : String = object["title"] {
                                        self.title1 = titleDataBase
                                    }
                                    if let statusDataBase : String = object["status"]{
                                        self.status = statusDataBase
                                    }
                                    if let detailDataBase : String = object["detail"]{
                                        self.detail = detailDataBase
                                    }
                                    if let sexDataBase : String = object["sex"]{
                                        self.sex = sexDataBase
                                    }
                                    if let ageDataBase : String = object["age"]{
                                        self.age = ageDataBase
                                    }
                                    if let appearanceDataBase : String = object["appearance"]{
                                        self.appearance = appearanceDataBase
                                    }
                                case let .failure(error):
                                    // 取得に失敗した場合の処理
                                    print("取得に失敗しました: \(error)")
                                }
                            })//ここまで
                        }
                        if(count1-num > 20){
                            print("count1-num:", count1-num)
                            title1 = "読み込み中"
                            status = "読み込み中"
                            detail = "読み込み中です。前画面へ戻ってください。"
                            sex = "読み込み中"
                            age = "読み込み中"
                            appearance = "読み込み中"
                        }
                        num = count1
                        self.recepArray.append([self.title1, self.status, self.detail, self.sex, self.age, self.appearance])
                        self.receptionTable.reloadData()
                        
                    }
                }
            }
        }
        
//        if(beacon.proximityUUID.uuidString == "48534442-4C45-4144-80C0-1800FFFFFFFF"){
//            recepArray.append(["意識を失う可能性があります。", "てんかん", "10～20分以内に意識が回復することが多いのでそのまま様子を見ていてかまいません。\nただ、けいれんが長時間にわたって止まらないときは救急車を読んでください。"])
//            receptionTable.reloadData()
//        }else{
//            recepArray.append(["未設定", "status", "detail"])
//            receptionTable.reloadData()
//        }

        /*
         beaconから取得できるデータ
         proximityUUID   :   regionの識別子
         major           :   識別子１
         minor           :   識別子２
         proximity       :   相対距離
         accuracy        :   精度
         rssi            :   電波強度
         */
//        if (beacon.proximity == CLProximity.unknown) {
//            //self.distance.text = "Unknown Proximity"
//            //reset()
//            recepArray = []
//            receptionTable.reloadData()
//            return
//        } else if (beacon.proximity == CLProximity.immediate) {
//            //self.distance.text = "Immediate"
//        } else if (beacon.proximity == CLProximity.near) {
//            //self.distance.text = "Near"
//        } else if (beacon.proximity == CLProximity.far) {
//            //self.distance.text = "Far"
//        }
        //        self.status.text   = "領域内です"
        //        self.uuid.text     = beacon.proximityUUID.uuidString
        //        self.major.text    = "\(beacon.major)"
        //        self.minor.text    = "\(beacon.minor)"
        //        self.accuracy.text = "accu\(beacon.accuracy)"
        //        self.rssi.text     = "rssi\(beacon.rssi)"
    }

}
