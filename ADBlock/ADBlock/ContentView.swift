//
//  ContentView.swift
//  ADBlock
//
//  Created by speedy on 2024/12/21.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @State private var isConfigured = false
    
    var body: some View {
        VStack {
            Text("Ad Blocker Status")
                .font(.title)
            
            Button("Check Configuration") {
                checkConfiguration()
            }
            .padding()
            
            if isConfigured {
                Text("✅ Content Blocker is properly configured")
                    .foregroundColor(.green)
            } else {
                Text("❌ Configuration issues detected")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func checkConfiguration() {
        SFContentBlockerManager.getStateOfContentBlocker(
            withIdentifier: "com.yourcompany.appname.extension") { state, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Configuration error: \(error)")
                    isConfigured = false
                } else {
                    isConfigured = state?.isEnabled ?? false
                }
            }
        }
    }
}
    
    func reloadContentBlocker() {
        SFContentBlockerManager.reloadContentBlocker(
            withIdentifier: "com.yourapp.ContentBlockerExtension") { error in
            if let error = error {
                print("Error reloading content blocker: \(error)")
            } else {
                print("Content blocker reloaded successfully")
            }
        }
    }

#Preview {
    ContentView()
}
