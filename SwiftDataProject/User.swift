//
//  User.swift
//  SwiftDataProject
//
//  Created by Naveed on 09/09/2024.
//

import Foundation
import SwiftData

@Model
class User: Identifiable, Hashable {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
