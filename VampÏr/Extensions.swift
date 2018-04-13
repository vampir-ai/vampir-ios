//
//  Extensions.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import Foundation
extension UserDefaults {
    func boolForKey(key: String) -> Bool? {
        var value: Bool?
        if let boolData = data(forKey: key) {
            value = NSKeyedUnarchiver.unarchiveObject(with: boolData) as? Bool
        }
        return value
    }

    
func setBool(value: Bool, forKey key: String) {
    var boolData: NSData?
    if value == value {
        boolData = NSKeyedArchiver.archivedData(withRootObject: value) as NSData?
    }
    set(boolData, forKey: key)
}
}

