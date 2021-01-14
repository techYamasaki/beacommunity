//
//  SharingViewListStruct.swift
//  becommunity
//
//  Created by yamasaki kounosuke on 2019/11/09.
//  Copyright © 2019年 yamasaki kounosuke. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // 角丸設定
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
        print("touchesBegan")
    }
}

//extension UserDefaults {
//
//    static let dataKey = "udkey"
//
//    static func setDataAsEncode(data: Array<SharingViewListData>)
//    {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(data)
//        {
//            self.standard.set(encoded, forKey: dataKey)
//            self.standard.synchronize()
//        }
//        else{
//            print("not save data")
//        }
//    }
//
//    static func fetchData()->Array<SharingViewListData>
//    {
//        if let savedData = self.standard.object(forKey: dataKey) as? Data
//        {
//            let decoder = JSONDecoder()
//            if let loadedData = try? decoder.decode(Array<SharingViewListData>.self, from: savedData)
//            {
//                return loadedData
//
//            }else{
//                return []
//            }
//        }else{
//            return []
//        }
//    }
//
//}


struct SharingViewListData: Codable
{
    var title: String
    var status: String
    var detail: String
    //var buttonStatus: Bool = false
    
    init(title: String, status: String, detail: String)
    {
        self.title = title
        self.status = status
        self.detail = detail
    }
    
}

func rrr(){
    print(1)
}
