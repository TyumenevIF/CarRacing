//
//  UserDataModel.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 24.02.2024.
//

import Foundation

struct UsersDataModel: Codable {
    var userName : String?
    var dateOfBirth : String?
    var userAvatarLocalPath : String?
    var points: Int?
    var gameDate: String?
}
