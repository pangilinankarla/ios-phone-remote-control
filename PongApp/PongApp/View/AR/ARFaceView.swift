//
//  ARFaceView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct ARFaceView: View {
  @State private var log = ""
    var body: some View {
      VStack {
        ARViewContainer(message: $log)
          .edgesIgnoringSafeArea(.all)
        
        Text("\(log)")
      }
        
    }
}

struct ARFaceView_Previews: PreviewProvider {
    static var previews: some View {
        ARFaceView()
    }
}
