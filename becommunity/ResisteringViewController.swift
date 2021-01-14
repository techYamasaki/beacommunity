//
//  ResisteringViewController.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/10/05.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit

class ResisteringViewController: UIViewController, UITextFieldDelegate {
    
    var selectedRow: Int!
    var selectedMemo: [String]!
    let ud = UserDefaults.standard
    var saveMemoArray: [[Any]] = []
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    
    var isDelete: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        statusField.delegate = self
        saveMemoArray = ud.array(forKey: "udkey") as![[Any]]
        titleField.text! = saveMemoArray[selectedRow][0] as! String
        statusField.text! = saveMemoArray[selectedRow][1] as! String
        detailTextView.text! = saveMemoArray[selectedRow][2] as! String
        print("success")

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteMemo(_ sender: Any) {
        if (selectedRow == 0 || selectedRow == 1 || selectedRow == 2){
            // カスタマイズ編：ダイアログを作成
            let alertController = UIAlertController(title: "【確認】", message: "これは消すことができません。", preferredStyle: .alert)
            // ダイアログに表示させるOKボタンを作成
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            // アクションを追加
            alertController.addAction(defaultAction)
            // ダイアログの表示
            present(alertController, animated: true, completion: nil)
        }else{
            isDelete = true
            saveMemoArray.remove(at: selectedRow)
            ud.set(saveMemoArray, forKey: "udkey" )
            ud.synchronize()
            print("remove")
            //画面遷移
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        print("touchesBeganエラー")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる(1)
        textField.resignFirstResponder()
        return true
    }
    
        
//        saveMemoArray[selectedRow][0] = titleField.text!
//        saveMemoArray[selectedRow][1] = statusField.text!
//        saveMemoArray[selectedRow][2] = detailTextView.text!
//        ud.set(saveMemoArray, forKey: "udkey" )
//        ud.synchronize()
//
//        //画面遷移
//        self.navigationController?.popViewController(animated: true)
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isDelete == false{
        saveMemoArray[selectedRow][0] = titleField.text!
        saveMemoArray[selectedRow][1] = statusField.text!
        saveMemoArray[selectedRow][2] = detailTextView.text!
        ud.set(saveMemoArray, forKey: "udkey" )
        ud.synchronize()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 入力を反映させたテキストを取得する
        let resultText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if resultText.count <= 13 {
            return true
        }
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
