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
                            try! s.write(from: "SIG Close Socket")
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
                TouchableViewContainer()
                HStack{
                    buttonAView()
                    buttonBView()
                    buttonXView()
                    buttonYView()
                }
                
            }
            
        }
    }
}


struct TouchableViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIViewType {
        return TouchableView(frame: .zero)
    }
    
    func updateUIView(_ uiView: TouchableView, context: Context) {}
}

class TouchableView: UIView {
    var touchViews = [UITouch:TouchSpotView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            createViewForTouch(touch: touch)
        }
    }
 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       for touch in touches {
           let view = viewForTouch(touch: touch)
           // Move the view to the new location.
           let newLocation = touch.location(in: self)
           let normalizedForce = touch.force / CGFloat(5.555556)
           view?.center = newLocation
           view?.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
           if globalObj.socket.isConnected{
               try! globalObj.socket.write(from: normalizedForce.formatted())
           }
           globalObj.force = normalizedForce
       }
   }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    
    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        newView.center = touch.location(in: self)
        
        // Add the view and animate it to a new size.
        addSubview(newView)
        let normalizedForce = touch.force / touch.maximumPossibleForce
        newView.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
        
        // Save the views internally
        touchViews[touch] = newView
        
    }
    
    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }
    
    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }
}



class TouchSpotView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // Update the corner radius when the bounds change.
   override var bounds: CGRect {
       get { return super.bounds }
       set(newBounds) {
           super.bounds = newBounds
           layer.cornerRadius = newBounds.size.width / 2.0
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
