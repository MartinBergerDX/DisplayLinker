//
//  DisplayLinker.swift
//  DisplayLinker
//
//  Created by Martin Berger on 10/12/16.
//  Copyright © 2016 heavy-debugging.inc All rights reserved.
//

import UIKit

protocol DisplayLinkerDelegate: class {
    func displayWillUpdate(delta: TimeInterval)
}

protocol DisplayLinkerProtocol {
    init(withDelegate delegate: DisplayLinkerDelegate?)
    func pause(should : Bool)
    func start();
    func stop();
}

class DisplayLinker: DisplayLinkerProtocol {
    internal var linker: CADisplayLink? = nil
    internal var previous: CFTimeInterval? = 0.0
    internal var zero: Bool? = true
    internal weak var delegate: DisplayLinkerDelegate? = nil
    
    internal required init(withDelegate delegate: DisplayLinkerDelegate?) {
        setup(withDelegate: delegate)
    }
    
    internal init() {
        
    }
    
    internal func setup(withDelegate delegate: DisplayLinkerDelegate?) {
        self.delegate = delegate
        start()
    }
    
    internal func pause(should : Bool) {
        self.linker?.isPaused = should
    }
    
    internal func start() {
        self.linker = CADisplayLink.init(target: self, selector: #selector(update(displayLink:)))
        self.linker?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    internal func stop() {
        self.linker?.invalidate()
        self.linker?.remove(from: RunLoop.main, forMode: .defaultRunLoopMode)
        self.zero = true
    }
    
    @objc internal func update(displayLink: CADisplayLink) -> Void {
        let current: CFTimeInterval! = self.linker?.timestamp
        var delta: CFTimeInterval? = 0.0
        if self.zero == true {
            self.zero = false
        }
        else {
            delta = current - self.previous!
        }
        
        self.previous = current
        
        self.delegate?.displayWillUpdate(delta: delta!)
    }
}
