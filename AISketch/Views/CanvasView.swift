//
//  CanvasView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import SwiftUI

struct CanvasView: View {
    @State private var points: [Point] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            HStack {
                // Clear Button
                Button (action: {
                    points.removeAll()
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
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                let location = value.location
                                let newPoint = Point(x: location.x, y: location.y)
                                points.append(newPoint)
                            }
                    )
                
                // Draw Points
                    ForEach(points) { point in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: point.x, y: point.y)
                }
            }
        }
    }
}

#Preview {
    CanvasView()
}
