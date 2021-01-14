//
//  SharingTableViewCell.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/11/09.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import Foundation
import UIKit


class InitTBCell: UITableViewCell
{
    
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        initSetting()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func initSetting()
//    {
//
//    }
    
}

class SharingTableViewCell: InitTBCell
{
    @IBOutlet weak var tapSwitch: UISwitch!
    //    var indexpath: Int?
//    let ud = UserDefaults.standard
//    let settingKey = "toggle"
//    
//    var switchStatus: Bool?
//    {
//        didSet{
//            
//            if let _isOn = switchStatus{
//                switchButton.isOn = _isOn
//            }
//        }
//    }
//    lazy var switchButton: UISwitch = {
//        let switchBtn = UISwitch()
//        switchBtn.tintColor = UIColor.orange
//        switchBtn.addTarget(self, action: #selector(toggleSwitchHandler), for: UIControlEvents.touchUpInside)
//        return switchBtn
//    }()
//    
//    
//    override func initSetting() {
//        
//        self.addSubview(switchButton)
//        switchButton.translatesAutoresizingMaskIntoConstraints = false
//        switchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        switchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
//    
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        //switchStatus = nil
//    }
//    
//    
//    @objc func toggleSwitchHandler(_ sender: UISwitch)
//    {
//        if let num = indexpath{
//            ud.setValue(num, forKey: settingKey)
//            print(num)
//        }
//        
//        switchButton.isEnabled = false
//    }
    
}

