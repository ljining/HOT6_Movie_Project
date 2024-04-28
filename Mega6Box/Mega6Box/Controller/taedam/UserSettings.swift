//
//  UserSettings.swift
//  Mega6Box
//
//  Created by 김태담 on 4/23/24.
//

import Foundation

class UserSettings {
    static let shared = UserSettings()

    private let defaults = UserDefaults.standard

    var userID: String? {
        get { defaults.string(forKey: "userID") }
        set { defaults.set(newValue, forKey: "userID") }
    }

    var password: String? {
        get { defaults.string(forKey: "password") }
        set { defaults.set(newValue, forKey: "password") }
    }

    var name: String? {
        get { defaults.string(forKey: "name") }
        set { defaults.set(newValue, forKey: "name") }
    }

    var phoneNumber: String? {
        get { defaults.string(forKey: "phoneNumber") }
        set { defaults.set(newValue, forKey: "phoneNumber") }
    }
    var nickName: String? {
        get { defaults.string(forKey: "nickName") }
        set { defaults.set(newValue, forKey: "nickName") }
    }
    var auto: Bool? {
            get {
                return defaults.bool(forKey: "autoKey") // Use a string key
            }
            set {
                defaults.set(newValue, forKey: "autoKey") // Save the new value using the same key
            }
        }

    var birthDate: Date? {
        get {
            guard let timestamp = defaults.object(forKey: "birthDate") as? TimeInterval else { return nil }
            return Date(timeIntervalSince1970: timestamp)
        }
        set {
            if let date = newValue {
                let timestamp = date.timeIntervalSince1970
                defaults.set(timestamp, forKey: "birthDate")
            }
        }
    }
}
