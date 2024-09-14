//
//  AddUserView.swift
//  SwiftDataProject
//
//  Created by Naveed on 14/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct AddUserView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State var user: User = User(name: "", city: "", joinDate: Date.now)
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $user.name)
                TextField("City", text: $user.city)
                DatePicker("Join Date", selection: $user.joinDate, displayedComponents: .date)
            }
            .navigationTitle("Add User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    modelContext.insert(user)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Naveed", city: "Lahore", joinDate: .now)
        
        return AddUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
}
