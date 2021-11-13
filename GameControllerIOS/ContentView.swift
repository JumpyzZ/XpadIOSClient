//
//  ContentView.swift
//  GameControllerIOS
//
//  Created by zhu on 2021/11/10.
//

import SwiftUI
import Socket
import GameController

struct ContentView: View {
    @State var isListening = false
    @State var isConnected = false
    var body: some View {
        VStack{
            VStack{
                HStack {
                    Button(action: {
                        if !(isListening || isConnected){
                            let s = globalObj.socket
                            try! s.listen(on: 5050)
                            isListening = s.isListening
                            isConnected = s.isConnected
                        }
                    }) {
                        Text("Start Listen")
                    }
                    Button(action: {
                        if isListening && !isConnected{
                            let s = globalObj.socket
                            try! s.acceptConnection()
                            isListening = s.isListening
                            isConnected = s.isConnected
                        }
                    }) {
                        Text("Accept connection")
                    }
                    Button(action: {
                        if isConnected{
                            let s = globalObj.socket
                            try! s.write(from: "<SIG>Close Connection</SIG>")
                            s.close()
                            isListening = s.isListening
                            isConnected = s.isConnected
                            globalObj.socket = try! Socket.create()
                        }
                    }) {
                        Text("Close Connection")
                    }
                    HStack{
                        if !(isListening || isConnected){
                            Image(systemName: "bolt.horizontal.circle.fill")
                                .foregroundColor(.red)
                        }
                        else{
                            if isListening{
                                Image(systemName: "bolt.horizontal.circle.fill")
                                    .foregroundColor(.yellow)
                            }
                            if isConnected{
                                Image(systemName: "bolt.horizontal.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            ZStack{
                backgroundTouchableView()
                dpadView()
            }
        }
    }
}





























































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOS 15.0, *) {
                ContentView()
.previewInterfaceOrientation(.landscapeLeft)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
