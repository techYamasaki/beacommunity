//
//  SettingViewController.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/09/18.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate/*, UIScrollViewDelegate*/{
    @IBOutlet weak var sexSegment: UISegmentedControl!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var appearanceText: UITextView!
    //@IBOutlet weak var profileScroll: UIScrollView!
    
    
    
    let ud = UserDefaults.standard
    
    var message: [Any] = [3, "指定しない", "指定しない"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageText.delegate = self
        //profileScroll.delegate = self

        //self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        if ud.array(forKey: "setting") == nil{
            print(1)
            sexSegment.selectedSegmentIndex = (message[0] as? Int)!
            ageText.text = message[1] as? String
            appearanceText.text = message[2] as? String
            ud.set(message, forKey: "setting")
            ud.synchronize()
        } else {
            message = ud.array(forKey: "setting")!
            sexSegment.selectedSegmentIndex = (message[0] as? Int)!
            ageText.text = message[1] as? String
            appearanceText.text = message[2] as? String
            print(2)
            //ud.set(memoArray, forKey: "udkey")
            //ud.synchronize()
            //testArray = ud.array(forKey: "udkey") as![[Any]]
            //print("testArray:\(testArray)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        message[0] = sexSegment.selectedSegmentIndex
        message[1] = ageText.text!
        message[2] = appearanceText.text!
        ud.set(message, forKey: "setting")
        ud.synchronize()
    }
    
    //呼ばれない
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
//        let text: String = ageText.text!
//        ageText.text = String(text.prefix(5))
        print("touchesBeganエラー")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる(1)
//        let text: String = ageText.text!
//        ageText.text = String(text.prefix(5))
        textField.resignFirstResponder()
        return true
    }
    
//    @objc func textFieldEditingChanged(textField: UITextField) {
//        guard let text = textField.text else { return }
//        textField.text = String(text.prefix(5))
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 入力を反映させたテキストを取得する
        let resultText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if resultText.count <= 7 {
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
