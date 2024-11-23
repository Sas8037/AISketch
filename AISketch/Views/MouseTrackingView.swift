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

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let trackingArea = NSTrackingArea(
            rect: .zero,
            options: [.mouseMoved, .activeInKeyWindow, .inVisibleRect],
            owner: context.coordinator,
            userInfo: nil
        )
        view.addTrackingArea(trackingArea)
        view.postsFrameChangedNotifications = true
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.frameDidChange), name: NSView.frameDidChangeNotification, object: view)
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        context.coordinator.isAddingPointsEnabled = isAddingPointsEnabled
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: MouseTrackingView
        var isAddingPointsEnabled: Bool = false

        init(_ parent: MouseTrackingView) {
            self.parent = parent
        }

        @objc func frameDidChange(_ notification: Notification) {
            if let view = notification.object as? NSView, let window = view.window {
                let mouseLocation = window.mouseLocationOutsideOfEventStream
                let localPosition = view.convert(mouseLocation, from: nil)
                parent.mousePosition = localPosition
            }
        }

        func mouseMoved(with event: NSEvent) {
            guard isAddingPointsEnabled else { return }
            if let view = event.window?.contentView {
                let localPosition = view.convert(event.locationInWindow, from: nil)
                parent.mousePosition = localPosition
            }
        }
    }
}

#Preview {
    MouseTrackingView(mousePosition: .constant(CGPoint.zero), isAddingPointsEnabled: .constant(true))
}
