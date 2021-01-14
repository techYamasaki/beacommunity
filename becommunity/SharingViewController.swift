//
//  SharingViewController.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/09/18.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class SharingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CBPeripheralManagerDelegate {
    
    @IBOutlet weak public var memoTableView: UITableView!
    var memoArray: [[Any]] = [["緊急SOS", "-", "周囲に不審な様子がないか確認してください。", false],["配慮が必要です", "-", "オフライン用メッセージから発信されています。", false],["手助けが必要です", "-", "オフライン用メッセージから発信されています。", false]]
    var testArray: [[String]] = []
    var profile: [String] = ["指定しない", "指定しない", "指定しない"]
    let ud = UserDefaults.standard
    let idfv = UIDevice.current.identifierForVendor?.uuidString
    var selectedToggle: Int = -1
    let settingKey = "toggle"
    let tableViewCellID = "customeCellID"
    var isAdver: Bool = false
    var isAdvertising: Bool!
    // PheripheralManager.
    var myPheripheralManager:CBPeripheralManager!
//    var data: [SharingViewListData] = [
//        SharingViewListData(title:"未設定111", status: "status", detail: "detail"),
//        SharingViewListData(title:"未設定", status: "status", detail: "detail"),
//        SharingViewListData(title:"未設定", status: "status", detail: "detail")
//        ]
//
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idfv!)
        print(type(of: idfv!))
        //idfv:325A7AF7-64F1-4AAF-B5AA-C11A556B39B7
        
        
        memoTableView.delegate = self
        memoTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //カスタムセル定義
        //memoTableView.register(SharingTableViewCell.self, forCellReuseIdentifier: tableViewCellID)
        
        // PeripheralManagerを定義.
        myPheripheralManager = CBPeripheralManager()
        myPheripheralManager.delegate = self
        
        isAdvertising = false
        
        if ud.array(forKey: "setting") != nil{
            let settingArray: [Any] = ud.array(forKey: "setting")!
            if ((settingArray[0] as? Int)! == 0){
                profile[0] = "女性"
            }else if((settingArray[0] as? Int)! == 1){
                profile[0] = "男性"
            }else if((settingArray[0] as? Int)! == 2){
                profile[0] = "その他"
            }else{
                profile[0] = "指定しない"
            }
            profile[1] = (settingArray[1] as? String)!
            profile[2] = (settingArray[2] as? String)!
        }else{
            profile = ["指定しない", "指定しない", "指定しない"]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheralManagerDidUpdateState")
    }
    
    
    
    
    //自作関数
    func advertiseBeacon(){
        if(isAdvertising == false) {
            print("発信")
            // iBeaconのUUID.
            let myProximityUUID = NSUUID(uuidString: "uuid")
            
            // iBeaconのIdentifier.
            let myIdentifier = "fabo2"
            
            // Major.
            let myMajor : CLBeaconMajorValue = 1
            
            // Minor.
            //iphone6
            var myMinor : CLBeaconMinorValue = 100
            //iphone5
            //var myMinor : CLBeaconMinorValue = 101
            if selectedToggle == 0{
                myMinor = 1
            }else if selectedToggle == 1{
                myMinor = 2
            }else if selectedToggle == 2{
                myMinor = 3
            }else{
                let object : NCMBObject = NCMBObject(className: "message")
                // objectIdプロパティを設定
                //iphone6
                object.objectId = "id"
                //iphone5
                //object.objectId = "id"
                // オブジェクトに値を設定
                object["title"] = memoArray[selectedToggle][0] as? String
                object["status"] = memoArray[selectedToggle][1] as? String
                object["detail"] = memoArray[selectedToggle][2] as? String
                object["sex"] = profile[0]
                object["age"] = profile[1]
                object["appearance"] = profile[2]
                
                // データストアへの登録を実施
                object.saveInBackground(callback: { result in
                    switch result {
                    case .success:
                        // 保存に成功した場合の処理
                        print("保存に成功しました")
                    case let .failure(error):
                        // 保存に失敗した場合の処理
                        print("保存に失敗しました: \(error)")
                    }
                })
            }
            // BeaconRegionを定義.
            let myBeaconRegion = CLBeaconRegion(proximityUUID: myProximityUUID! as UUID, major: myMajor, minor: myMinor, identifier: myIdentifier)
            
            // Advertisingのフォーマットを作成.
            let myBeaconPeripheralData = NSDictionary(dictionary: myBeaconRegion.peripheralData(withMeasuredPower: nil))
            print(4)
            print(isAdvertising)
            
            // Advertisingを発信.
            myPheripheralManager.startAdvertising(myBeaconPeripheralData as? [String : AnyObject])
            
            // カスタマイズ編：ダイアログを作成
            let alertController = UIAlertController(title: "【確認】", message: "情報を発信しました。", preferredStyle: .alert)
            // ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションを追加
            alertController.addAction(defaultAction)
            // ダイアログの表示
            present(alertController, animated: true, completion: nil)
        } else {
            print("停止")
            print(3)
            print(isAdvertising)
            myPheripheralManager.stopAdvertising()
            isAdvertising = false
        }
    }
    
    //Advertisingが始まると呼ばれる.
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("peripheralManagerDidStartAdvertising")
        print(isAdvertising)
        isAdvertising = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! SharingTableViewCell
        
        //selectedToggle = ud.integer(forKey: settingKey)
        //cell.indexpath = indexPath.row
        cell.textLabel?.text = memoArray[indexPath.row][0] as? String
        //cell.switchStatus = memoArray[indexPath.row][3] as? Bool
        if isAdver == true && indexPath.row != selectedToggle{
        cell.tapSwitch.isEnabled = false
        }else{cell.tapSwitch.isEnabled = true}
        print("tableload")
        return cell
    }
    
    @IBAction func addNewData(_ sender: Any) {
        memoArray.append(["未記入", "未記入", "未記入", false])
        memoTableView.reloadData()
        ud.set(memoArray, forKey: "udkey")
        ud.synchronize()
        //testArray = ud.array(forKey: "udkey") as![[String]]
        print("testArray:\(testArray)")
        print("udset_add")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (isAdver == false && indexPath.row != 0 && indexPath.row != 1 && indexPath.row != 2){
        self.performSegue(withIdentifier: "toResister", sender: nil)
        }
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toResister"{
            //detailViewControllerを取得
            //as! DetailViewControllerでダウンキャストしている
            let resisteringViewController = segue.destination as! ResisteringViewController
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
            resisteringViewController.selectedMemo = memoArray[selectedIndexPath.row] as? [String]
            resisteringViewController.selectedRow = selectedIndexPath.row
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ud.array(forKey: "udkey") != nil{
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            memoArray = ud.array(forKey: "udkey") as![[Any]]
            print("memoArray:\(memoArray)")
            memoTableView.reloadData()
            print("データ更新")
        } else {
            ud.set(memoArray, forKey: "udkey")
            ud.synchronize()
            //testArray = ud.array(forKey: "udkey") as![[Any]]
            print("testArray:\(testArray)")
            print("init_udset")
        }
    }
    
    func reloadsss(){
        memoTableView.reloadData()
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//        if let indexPath = memoTableView.indexPath(for: sender.superview!.superview as! UITableViewCell) {
//            print(indexPath[1])
//        } else {
//            //ここには来ないはず
//            print("not found...")
//        }
    @IBAction func tapSwitch(_ sender: UISwitch) {
        isAdver = !isAdver
        if let indexPath = memoTableView.indexPath(for: sender.superview!.superview as! UITableViewCell) {
            selectedToggle = indexPath[1]
            print(indexPath[1])
            memoTableView.reloadData()
                    } else {
                        //ここには来ないはず
                        print("not found...")
                    }
        
        advertiseBeacon()
        }
}
