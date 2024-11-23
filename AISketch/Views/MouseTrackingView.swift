//
//  MouseTrackingView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import SwiftUI
import AppKit

struct MouseTrackingView: NSViewRepresentable {
    @Binding var mousePosition: CGPoint

    func makeNSView(context: Context) -> NSView {
        let view = TrackingNSView()
        view.delegate = context.coordinator
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        // No dynamic updates required
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, TrackingNSViewDelegate {
        var parent: MouseTrackingView
        
        init(_ parent: MouseTrackingView) {
            self.parent = parent
        }
        func mouseDidMove(to point: CGPoint) {
            DispatchQueue.main.async {
                self.parent.mousePosition = point
            }
        }
    }
}


