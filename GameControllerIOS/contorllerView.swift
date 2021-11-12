//
//  contorllerView.swift
//  GameControllerIOS
//
//  Created by zhu on 2021/11/12.
//

import SwiftUI

struct buttonAView: View {
    @State var pressed = false
    var body: some View {
        Image(systemName: pressed ? "a.circle" : "a.circle.fill")
            .scaleEffect(2.3)
            .padding(15)
            .contentShape(Rectangle())
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    print("A Pressed")
                                    pressed = true
                                    
                                })
                                .onEnded({ _ in
                                    print("A Released")
                                    pressed = false
                                })
                        )
    }
}

struct buttonBView: View {
    @State var pressed = false
    var body: some View {
        Image(systemName: pressed ? "b.circle" : "b.circle.fill")
            .scaleEffect(2.3)
            .padding(15)
            .contentShape(Rectangle())
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    print("B Pressed")
                                    pressed = true
                                    
                                })
                                .onEnded({ _ in
                                    print("B Released")
                                    pressed = false
                                })
                        )
    }
}

struct buttonXView: View {
    @State var pressed = false
    var body: some View {
        Image(systemName: pressed ? "x.circle" : "x.circle.fill")
            .scaleEffect(2.3)
            .padding(15)
            .contentShape(Rectangle())
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    print("X Pressed")
                                    pressed = true
                                    
                                })
                                .onEnded({ _ in
                                    print("X Released")
                                    pressed = false
                                })
                        )
    }
}

struct buttonYView: View {
    @State var pressed = false
    var body: some View {
        Image(systemName: pressed ? "y.circle" : "y.circle.fill")
            .scaleEffect(2.3)
            .padding(15)
            .contentShape(Rectangle())
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    print("Y Pressed")
                                    pressed = true
                                    
                                })
                                .onEnded({ _ in
                                    print("Y Released")
                                    pressed = false
                                })
                        )
    }
}
struct contorllerView_Previews: PreviewProvider {
    static var previews: some View {
        buttonAView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
