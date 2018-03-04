//
//  View.swift
//  PongController
//
//  Created by david padawer on 3/3/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import Foundation
import UIKit

class View : UIView {

    var upTouchDownCallback : (() -> Void)?
    var upTouchUpCallback : (() -> Void)?
    var downTouchDownCallback : (() -> Void)?
    var downTouchUpCallback : (() -> Void)?



    @IBAction func upButtonTouchDown(_ sender: Any) {
        self.upTouchDownCallback?()
    }

    @IBAction func upButtonTouchUp(_ sender: Any) {
        self.upTouchUpCallback?()
    }

    @IBAction func downButtonTouchDown(_ sender: Any) {
        self.downTouchDownCallback?()
    }

    @IBAction func downButtonTouchUp(_ sender: Any) {
        self.downTouchUpCallback?()
    }
}
