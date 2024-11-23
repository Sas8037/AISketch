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
    @Binding var isAddingPointsEnabled: Bool
    @Binding var isMouseOverCanvas: Bool // New Binding

    typealias NSViewType = TrackingNSView

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> TrackingNSView {
        let view = TrackingNSView()
        view.delegate = context.coordinator
        return view
    }

    func updateNSView(_ nsView: TrackingNSView, context: Context) {
        // Pass the isAddingPointsEnabled state to the NSView
        nsView.isAddingPointsEnabled = isAddingPointsEnabled
    }

    // Coordinator to handle events from NSView
    class Coordinator: NSObject, TrackingNSViewDelegate {
        var parent: MouseTrackingView

        init(_ parent: MouseTrackingView) {
            self.parent = parent
        }

        func mouseDidMove(to point: CGPoint) {
            // Update the binding on the main thread
            DispatchQueue.main.async {
                self.parent.mousePosition = point
            }
        }

        func mouseDidEnter() {
            DispatchQueue.main.async {
                self.parent.isMouseOverCanvas = true
            }
        }

        func mouseDidExit() {
            DispatchQueue.main.async {
                self.parent.isMouseOverCanvas = false
            }
        }
    }
}
