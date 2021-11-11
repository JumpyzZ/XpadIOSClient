//
//  GameControllerIOSApp.swift
//  GameControllerIOS
//
//  Created by zhu on 2021/11/10.
//

import SwiftUI
import GameController
import Socket

@main
struct GameControllerIOSApp: App {
    @StateObject var envObj = envObject()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(envObj)
        }
    }
}

class envObject: ObservableObject {
    @Published var socket: Socket
    var virtualConfiguration = GCVirtualController.Configuration()
    @Published var virtualController: GCVirtualController

    
    init(){
        self.socket = try! Socket.create()
        self.virtualConfiguration.elements = [GCInputButtonA,
                                         GCInputButtonB,
                                         GCInputButtonX,
                                         GCInputButtonY,
                                         GCInputDirectionPad,
                                         GCInputButtonHome,
                                         GCInputButtonShare,
                                         GCInputLeftShoulder,
                                         GCInputRightShoulder]
        self.virtualController = GCVirtualController(configuration: virtualConfiguration)
        self.virtualController.connect()
        print(1)
    }
}
