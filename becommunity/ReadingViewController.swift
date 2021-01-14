//
//  ReadingViewController.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/11/09.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import UIKit

class ReadingViewController: UIViewController {

    @IBOutlet weak var readTitle: UILabel!
    
    @IBOutlet weak var readStatus: UILabel!
    
    @IBOutlet weak var readDetail: UITextView!
    
    @IBOutlet weak var readAppearance: UITextView!
    var checkData: [String]!
    
    @IBOutlet weak var readSex: UILabel!
    
    @IBOutlet weak var readAge: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readTitle.text = checkData[0]
        readStatus.text = checkData[1]
        readDetail.text = checkData[2]
        readSex.text = checkData[3]
        readAge.text = checkData[4]
        readAppearance.text = checkData[5]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
