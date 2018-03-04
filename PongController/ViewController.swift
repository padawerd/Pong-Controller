//
//  ViewController.swift
//  PongController
//
//  Created by david padawer on 3/3/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bluetoothManager : BluetoothManager!
    //up, down
    var buttonPresses = [false, false] {
        didSet {
            self.bluetoothManager.updateButtonPresses(upPressed: buttonPresses[0], downPressed: buttonPresses[1])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let customView = view as! View
        self.bluetoothManager = BluetoothManager()
        bluetoothManager.poweredOnCallback = {() in customView.backgroundColor = .green}
        bluetoothManager.poweredOffCallback = {() in customView.backgroundColor = .purple}
        customView.upTouchDownCallback = {[weak self] () in self?.buttonPresses[0] = true}
        customView.upTouchUpCallback = {[weak self] () in self?.buttonPresses[0] = false}
        customView.downTouchDownCallback = {[weak self] () in self?.buttonPresses[1] = true}
        customView.downTouchUpCallback = {[weak self] () in self?.buttonPresses[1] = false}




    }
}

