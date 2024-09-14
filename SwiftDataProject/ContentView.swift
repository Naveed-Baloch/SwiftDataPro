//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Naveed on 09/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var showFilters = false
    @State var showAddUserView = false
    @State var searchFilter = SearchFilter()
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if(showFilters) {
                    SearchFilterView(searchFilter: searchFilter, showFilters: $showFilters)
                        .padding(.top)
                }
                UsersView(
                    name: searchFilter.name.trimmingCharacters(in: .whitespacesAndNewlines),
                    joinDate: searchFilter.joinDate, includeDateFilter: searchFilter.includeDateFilter, sortOrder: searchFilter.sortOrder
                )
            }
            
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible)
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button(showFilters ? "Hide Filter" : "Filter") {
                    withAnimation{
                        showFilters.toggle()
                    }
                }
                Button("Add User", systemImage: "plus") {
                    showAddUserView.toggle()
                }
            }
            .sheet(isPresented: $showAddUserView){
                AddUserView()
            }
        }
    }
}

#Preview {
    ContentView()
}
