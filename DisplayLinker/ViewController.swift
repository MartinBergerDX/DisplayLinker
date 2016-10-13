//
//  ViewController.swift
//  DisplayLinker
//
//  Created by Martin Berger on 10/12/16.
//  Copyright © 2016 heavy-debugging.inc All rights reserved.
//

import UIKit

class ViewController: UIViewController, DisplayLinkerDelegate {
    var linker: DisplayLinker? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.linker = DisplayLinker.init(withDelegate: self)
    }

    func displayLinkUpdate(delta: TimeInterval) {
        print(String(format: "%2.4f", delta))
    }
}

