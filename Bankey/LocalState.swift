//
//  LocalState.swift
//  Bankey
//
//  Created by Jason Hung on 2024/5/26.
//

import Foundation

public class localState {
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        
        set(newValue) {
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}
