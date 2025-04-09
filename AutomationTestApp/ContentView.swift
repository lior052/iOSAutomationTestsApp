//
//  ContentView.swift
//  AutoTestApp
//
//  Created by lior on 30/03/2025.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showPopup = false
    @State private var inputText = ""
    @State private var savedText = ""
    @State private var scrollValue: Double = 50.0 // Default percentage
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Headline
                Text("App for Auto Tests")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                // Set Data Button
                Button("Set Data") {
                    showPopup = true
                }
                .buttonStyle(.borderedProminent)
                .accessibilityLabel(Text(""))
                .accessibilityIdentifier("setDataButton")
                
                // Disabled Text Control
                TextField("Text will appear here", text: $savedText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
                    .padding()
                    .accessibilityLabel(Text(""))
                    .accessibilityIdentifier("disabledTextField")
                
                // Horizontal Scroll Percentage Display
                VStack {
                    Text("Progress: \(Int(scrollValue))%")
                    Slider(value: $scrollValue, in: 0...100, step: 1)
                        .padding()
                        .accessibilityLabel(Text(""))
                        .accessibilityIdentifier("progressBar")
                }
                
                // Create a List Button (Navigates to new page)
                NavigationLink(destination: ListView()) {
                    Text("Create a List")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .accessibilityLabel(Text(""))
                .accessibilityIdentifier("listButton")
                
                
            }
            .padding()
            .sheet(isPresented: $showPopup) {
                PopupView(inputText: $inputText, showPopup: $showPopup, savedText: $savedText)
                    .presentationDetents([.fraction(0.3)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
