//
//  PopupView.swift
//  AutoTestApp
//
//  Created by lior on 30/03/2025.
//


import SwiftUI


struct PopupView: View {

    @Binding var inputText: String
    @Binding var showPopup: Bool
    @Binding var savedText: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Item")
                .font(.headline)
                .bold()

            TextField("Enter text", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .accessibilityIdentifier("popupTextField")

            HStack {
                Button("Cancel") {
                    showPopup = false
                }
                .buttonStyle(.bordered)
                .accessibilityIdentifier("popupCancelButton")

                Button("OK") {
                    savedText = inputText
                    showPopup = false
                }
                .buttonStyle(.borderedProminent)
                .accessibilityIdentifier("popupOKButton")
            }
        }
        .padding()
    }
}

