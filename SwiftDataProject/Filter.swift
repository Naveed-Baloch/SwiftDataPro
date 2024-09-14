//
//  Filter.swift
//  SwiftDataProject
//
//  Created by Naveed on 14/09/2024.
//

import Foundation
import SwiftData

@Observable
class SearchFilter {
    var name = ""
    var includeDateFilter = false
    var joinDate = Date()
    var sortOrder: [SortDescriptor<User>] = []
}
