//
//  TrackingNSView.swift
//  AISketch
//
//  Created by Saul Saavedra on 11/23/24.
//

import AppKit

// Protocol to communicate mouse movements
protocol TrackingNSViewDelegate: AnyObject {
    func mouseDidMove(to point: CGPoint)
}

class TrackingNSView: NSView {
    weak var delegate: TrackingNSViewDelegate?
    
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
        self.trackingAreas.forEach { self.removeTrackingArea($0) }
        
        let options: NSTrackingArea.Options = [.mouseMoved, .activeAlways, .inVisibleRect]
        let trackingArea = NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        setupTracking()
    }
    
    override func mouseMoved(with event: NSEvent) {
        let locationInView = self.convert(event.locationInWindow, from: nil)
        
        // Invert the y-coordinate based on the view's height
        let invertedY = self.bounds.height - locationInView.y
        let correctedLocation = CGPoint(x: locationInView.x, y: invertedY)
        
        delegate?.mouseDidMove(to: correctedLocation)
    }
}

