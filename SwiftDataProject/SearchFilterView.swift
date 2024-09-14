//
//  SearchFilterView.swift
//  SwiftDataProject
//
//  Created by Naveed on 14/09/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct SearchFilterView: View {
    @Bindable var searchFilter: SearchFilter
    @Binding var showFilters: Bool
    
    var body: some View {
        VStack{
            TextField("Search users...", text: $searchFilter.name)
                .padding()
                .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gray, lineWidth: 1)
                )
            Toggle("Include Date Filter", isOn: $searchFilter.includeDateFilter)
                .padding(5)
            if(searchFilter.includeDateFilter) {
                DatePicker("Join Date", selection: $searchFilter.joinDate, displayedComponents: .date)
                    .padding(5)
            }
            
            HStack {
                Menu {
                    Picker("Sort", selection: $searchFilter.sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                } label: {
                    Label("Sort by", systemImage: "arrow.up.arrow.down")
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity)
                
                if(!searchFilter.name.isEmpty || searchFilter.includeDateFilter) {
                    Button(
                        action: {
                            searchFilter.name = ""
                            searchFilter.includeDateFilter = false
                            searchFilter.joinDate = Date()
                            searchFilter.sortOrder = []
                            withAnimation {
                                showFilters.toggle()
                            }
                        }) {
                            Text("Reset")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.red.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    ZStack {
        @State var showFilters = false
        SearchFilterView(
            searchFilter: SearchFilter(),
            showFilters: $showFilters
        )
    }
}
