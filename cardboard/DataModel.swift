//
//  DataModel.swift
//  cardboard
//
//  Created by Aakash Thumaty on 3/1/18.
//  Copyright © 2018 Aakash Thumaty. All rights reserved.
//

import Foundation

let dataModelDidUpdateNotification = "dataModelDidUpdateNotification"

class DataModel {
    static var sharedInstance = DataModel()
    private init() { }
    
    
    func requestData() {
        
    }
    
    private (set) var data: String? {
        didSet {
            NotificationCenter.default.post(name:
                NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: nil)
            
        }
    }
    
     func getDataUpdate() {
        if let data = DataModel.sharedInstance.data {
            print(data)
        }
    }
}
