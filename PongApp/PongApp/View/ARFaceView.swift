//
//  ARFaceView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct ARFaceView: View {
    var body: some View {
      VStack {
        ARViewContainer()
          .edgesIgnoringSafeArea(.all)
        
        Text("Hello, World!")
      }
        
    }
}

struct ARFaceView_Previews: PreviewProvider {
    static var previews: some View {
        ARFaceView()
    }
}
