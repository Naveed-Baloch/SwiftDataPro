//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Naveed on 09/09/2024.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    @State private var showAddJobView = false
    
    var body: some View {
        
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
            
            Section("Jobs"){
                VStack(alignment: .leading) {
                    if user.jobs.isEmpty {
                        Text("User Don't have any Task Please add now!")
                            .multilineTextAlignment(.center)
                            .background(Color.white)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                        
                    } else {
                        List(user.jobs){ job in
                            Text(job.name)
                        }
                        
                    }
                    
                }
            }
        
            
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Assign Task") {
                showAddJobView.toggle()
            }
        }.sheet(isPresented: $showAddJobView, content: {
            AddJobView(user: user)
        })
    }
    
}

struct AddJobView: View {
    @State private var jobName = ""
    @Bindable var user: User
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("enter name of task...", text: $jobName)
                Button(
                    action: {
                        user.jobs.append(Job(name: jobName, owner: user))
                        dismiss()
                    }, label: {
                        Text("Assign")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.green.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    })
            }
            .navigationTitle("Assign Task")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
