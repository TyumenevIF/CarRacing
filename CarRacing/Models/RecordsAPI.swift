//
//  MockAPI.swift
//  CarRacing
//
//  Created by Ilyas Tyumenev on 25.02.2024.
//

import Foundation

class RecordsAPI {
    
    static func showRecords() -> [UsersDataModel]{
        let records = [
            UsersDataModel(userName: "Kelly Goodwin", dateOfBirth: "01.01.1999", points: 10, gameDate: "01.01.2024"),
            UsersDataModel(userName: "Mohammad Hussain", dateOfBirth: "01.02.1998", points: 33, gameDate: "02.01.2024"),
            UsersDataModel(userName: "John Young", dateOfBirth: "01.03.1997", points: 45, gameDate: "03.01.2024"),
            UsersDataModel(userName: "Tamilarasi Mohan", dateOfBirth: "01.04.1996", points: 99, gameDate: "04.01.2024"),
            UsersDataModel(userName: "Kim Yu", dateOfBirth: "01.05.1995", points: 0, gameDate: "05.01.2024"),
            UsersDataModel(userName: "Derek Fowler", dateOfBirth: "01.06.1994", points: 163, gameDate: "06.01.2024"),
            UsersDataModel(userName: "Shreya Nithin", dateOfBirth: "01.07.1993", points: 555, gameDate: "07.01.2024"),
            UsersDataModel(userName: "Emily Adams", dateOfBirth: "01.08.1992", points: 1000, gameDate: "08.01.2024"),
            UsersDataModel(userName: "Aabidah Amal", dateOfBirth: "01.09.1991", points: 222, gameDate: "09.01.2024")
        ]
        return records
    }
}
