//
//  CanvasView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import SwiftUI

struct CanvasView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            HStack {
                // Clear Button
                Button (action: {
                    // Clear Button
                }) {
                    Text("Clear")
                        .padding()
                }
                .buttonStyle(.plain)
                .background(Color.red)
                .cornerRadius(8)
            }
            .padding()
            
            // Canvas
            ZStack {
                // Canvas Background
                Color.white
            }
        }
    }
}

#Preview {
    CanvasView()
}
