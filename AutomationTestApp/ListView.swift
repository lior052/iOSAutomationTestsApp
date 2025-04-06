//
//  ListView.swift
//  AutomationTestApp
//
//  Created by lior on 30/03/2025.
//

import SwiftUI

struct ListView: View {
    @State private var items: [String] = []
    @State private var newItemText = ""
    @State private var selectedItems: Set<String> = []
    @State private var showInputDialog = false // Controls popup visibility
    
    var body: some View {
        VStack {
            // Title
            Text("My List")
                .font(.largeTitle)
                .bold()
                .padding()

            // List of items
            List {
                ForEach(Array(items.enumerated()), id: \.element) { index, item in
                    HStack {
                        Text("\(index + 1). \(item)")
                        Spacer()
                        if selectedItems.contains(item) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // Make whole row tappable
                    .onTapGesture {
                        toggleSelection(for: item)
                    }
                }
                .onDelete(perform: deleteItem)
            }

            Spacer()

            // Bottom buttons
            HStack {
                // Add Button - Shows an input popup
                Button(action: {
                    showInputDialog = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                }

                Spacer()


                // Delete Selected Button (Disabled if no items selected)
                Button(action: deleteSelectedItems) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 30))
                        .foregroundColor(selectedItems.isEmpty ? .gray : .red)
                }
                .disabled(selectedItems.isEmpty)
            }
            .padding()
        }
        .sheet(isPresented: $showInputDialog) {
            VStack(spacing: 20) {
                Text("Add New Item")
                    .font(.headline)
                
                TextField("Enter text", text: $newItemText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .accessibilityIdentifier("popupTextField")
                
                HStack {
                    Button("Cancel") {
                        showInputDialog = false
                    }
                    .buttonStyle(.bordered)
                    .accessibilityIdentifier("popupCancelButton")
                    
                    Button("OK") {
                        addItem()
                        showInputDialog = false
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityIdentifier("popupOKButton")
                    
                }
            }
            .padding()
            .presentationDetents([.fraction(0.3)])
            .presentationDragIndicator(.visible)
        }

    }

    // Toggle item selection
    private func toggleSelection(for item: String) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }

    // Add item to the list
    private func addItem() {
        let newItem = newItemText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !newItem.isEmpty {
            items.append(newItem)
            newItemText = "" // Clear input
        }
    }

    // Delete selected items
    private func deleteSelectedItems() {
        items.removeAll { selectedItems.contains($0) }
        selectedItems.removeAll()
    }

    // Swipe-to-delete
    private func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
