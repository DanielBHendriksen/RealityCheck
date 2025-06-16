//
//  ContentView.swift
//  RealityCheck
//
//  Created by Daniel Hendriksen on 15/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 40) {
            Text("RealityCheck")
                .font(.largeTitle)
                .padding(.top, 50)

            Button(action: {
                isLoading = true
                ModelGeneratorService.shared.generateAndPreviewModel { success in
                    DispatchQueue.main.async {
                        isLoading = false
                        if !success {
                            print("❌ Failed to launch AR model")
                        }
                    }
                }
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Generate & Launch AR")
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
