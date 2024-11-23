//
//  CanvasView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import SwiftUI

struct CanvasView: View {
    @State private var points: [Point] = []
    @State private var isAddingPointsEnabled: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Toolbar
            HStack {
                // Toggle Adding Points Button
                Button (action: {
                    isAddingPointsEnabled.toggle()
                }) {
                    Text(isAddingPointsEnabled ? "Disable Adding Points" : "Enable Adding Points")
                        .padding()
                }
                .buttonStyle(.plain)
                .background(isAddingPointsEnabled ? Color.red : Color.green)
                .cornerRadius(8)
                
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
                                if isAddingPointsEnabled {
                                    let location = value.location
                                    let newPoint = Point(x: location.x, y: location.y)
                                    points.append(newPoint)
                                }
                            }
                    )
                
                // Draw Points
                    ForEach(points) { point in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .position(x: point.x, y: point.y)
                }
                
                // Mouse Tracking Overlay
                
                // Circle Following Mouse Position when Adding Points is Enabled
                if isAddingPointsEnabled {
                    Circle()
                        .stroke(lineWidth: 1)
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.red)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CanvasView()
}
