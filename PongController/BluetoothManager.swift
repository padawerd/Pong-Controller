//
//  BluetoothManager.swift
//  PongController
//
//  Created by david padawer on 3/3/18.
//  Copyright © 2018 DPad Studios. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothManager : NSObject, CBPeripheralManagerDelegate {

    let serviceCBUUID = CBUUID(string: "ABB08141-B3E5-4667-9EEC-7102CB3BCA36")
    let characteristicCBUUID = CBUUID(string: "CB17C6B3-49A2-4AAA-B6A1-E70DC9C94C9B")

    var characteristic : CBMutableCharacteristic!
    var service : CBMutableService!

    var poweredOffCallback : (() -> Void)?
    var poweredOnCallback : (() -> Void)?

    var peripheralManager : CBPeripheralManager!

    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        self.service = CBMutableService(type: self.serviceCBUUID, primary: true)
        self.characteristic = CBMutableCharacteristic(type: self.characteristicCBUUID, properties: .notify, value: nil, permissions: .readable)
        self.service.characteristics = [characteristic]
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOff:
            self.poweredOffCallback?()
            break
        case .poweredOn:
            self.poweredOnCallback?()
            self.peripheralManager.removeAllServices()
            self.peripheralManager.add(self.service)
            self.peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "Pong Controller", CBAdvertisementDataServiceUUIDsKey : [self.serviceCBUUID]])
            break
        case .resetting:
            break
        case .unauthorized:
            break
        case .unknown:
            break
        case .unsupported:
            break
        }
    }

    func updateButtonPresses(upPressed: Bool, downPressed: Bool) {
        do {
            let data = try JSONSerialization.data(withJSONObject: ["upPressed": upPressed, "downPressed": downPressed], options: [])
            self.peripheralManager.updateValue(data, for: self.characteristic, onSubscribedCentrals: nil)
        } catch {

        }
    }
}
