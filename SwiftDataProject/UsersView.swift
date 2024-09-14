//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Naveed on 14/09/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct UsersView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var users: [User]
    
    init(name: String, joinDate: Date, includeDateFilter: Bool, sortOrder: [SortDescriptor<User>] = []) {
        _users = Query(
            filter: #Predicate<User>{ user in
                if !name.isEmpty && includeDateFilter {
                    return user.name.localizedStandardContains(name) && user.joinDate >= joinDate
                } else if name.isEmpty && includeDateFilter {
                    return user.joinDate >= joinDate
                } else if !name.isEmpty && !includeDateFilter {
                    return user.name.localizedStandardContains(name)
                } else {
                    return true
                }
            },
            sort: sortOrder)
    }
    
    var body: some View {
        GeometryReader { geometry in
            if users.isEmpty {
                Text("No Users found!")
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color.white)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            } else {
                
                List {
                    ForEach(users) { user in
                        NavigationLink(value: user) {
                            HStack {
                                Text(user.name)
                                    
                                Spacer()
                                Text(user.joinDate.formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    }
                    .onDelete(perform: removeUser)
                }
              
            }
        }
    }
    
    func removeUser(indexSet: IndexSet) {
        indexSet.forEach { index in
            let userToDelete = users[index]
            modelContext.delete(userToDelete)
        }
    }
}


#Preview {
    UsersView(name: "Test", joinDate: .now, includeDateFilter: false)
}
