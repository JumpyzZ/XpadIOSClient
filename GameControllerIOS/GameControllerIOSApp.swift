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
    let _foo = globalObj.force
    var body: some Scene {
        WindowGroup {
            //backgroundTouchableView()
            //dpadView()
            ContentView()
        }
    }
}
var globalObj = globalObject()

class globalObject: ObservableObject {
    @Published var socket: Socket
    @Published var force: CGFloat

    
    init(){
        self.socket = try! Socket.create()
        self.force = 0.0
    }
}
