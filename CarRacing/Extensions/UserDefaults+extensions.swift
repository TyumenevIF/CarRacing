//
//  UserDefaults+extensions.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 26.02.2024.
//

import Foundation

extension UserDefaults {

    func set<T: Encodable>(_ encodable: T, forKey: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            setValue(data, forKey: forKey)
        }
    }

    func value<T: Decodable>(_ type: T.Type, forKey: String) -> T? {
        if let data = object(forKey: forKey) as? Data,
           let result = try? JSONDecoder().decode(type, from: data) {
            return result
        }
        return nil
    }
}
