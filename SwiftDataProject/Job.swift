//
//  Job.swift
//  SwiftDataProject
//
//  Created by Naveed on 14/09/2024.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String
    var owner: User?

    init(name: String, owner: User? = nil) {
        self.name = name
        self.owner = owner
    }
}

