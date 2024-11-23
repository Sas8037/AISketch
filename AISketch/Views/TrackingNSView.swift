//
//  TrackingNSView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import AppKit

// Protocol to communicate mouse movements and enter/exit events
protocol TrackingNSViewDelegate: AnyObject {
    func mouseDidMove(to point: CGPoint)
    func mouseDidEnter()
    func mouseDidExit()
}

class TrackingNSView: NSView {
    weak var delegate: TrackingNSViewDelegate?
    var isAddingPointsEnabled: Bool = false

    private var trackingArea: NSTrackingArea?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        self.window?.acceptsMouseMovedEvents = true
        setupTracking()
    }

    private func setupTracking() {
        // Remove existing tracking areas to avoid duplicates
        if let existingTrackingArea = trackingArea {
            self.removeTrackingArea(existingTrackingArea)
        }

        // Create a tracking area to monitor mouse movements and enter/exit events
        let options: NSTrackingArea.Options = [.mouseMoved, .mouseEnteredAndExited, .activeAlways, .inVisibleRect]
        trackingArea = NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil)
        if let trackingArea = trackingArea {
            self.addTrackingArea(trackingArea)
        }
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        setupTracking()
    }

    override func mouseMoved(with event: NSEvent) {
        let locationInView = self.convert(event.locationInWindow, from: nil)

        // Invert the y-coordinate based on the view's height to match SwiftUI's coordinate system
        let invertedY = self.bounds.height - locationInView.y
        let correctedLocation = CGPoint(x: locationInView.x, y: invertedY)

        delegate?.mouseDidMove(to: correctedLocation)
    }

    override func mouseEntered(with event: NSEvent) {
        // Notify delegate that mouse entered
        delegate?.mouseDidEnter()

        // Change cursor when mouse enters the view
        if isAddingPointsEnabled {
            NSCursor.hide()
        } else {
            NSCursor.unhide()
        }
    }

    override func mouseExited(with event: NSEvent) {
        // Notify delegate that mouse exited
        delegate?.mouseDidExit()

        // Revert to default cursor when mouse exits the view
        NSCursor.unhide()
    }

    override func resetCursorRects() {
        super.resetCursorRects()
        // Optionally, define cursor rects if needed
    }
}
