//
//  MovementView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct MovementView: View {
  @StateObject private var service = SocketService()
  @State var isShowAR = false
  
    var body: some View {
      NavigationView {
        VStack {
          Button("Connect") {
            service.establishConnection()
          }
          
          Button("Disconnect") {
            service.closeConnection()
          }
          
          Button(action: {
            service.sendMove(Move(moveUp: true, moveDown: false))
          }) {
            HStack{
              Text("Up")
              .padding(.horizontal)
            }
            .padding()
          }
          .frame(width: 200, height: 60, alignment: .center)
          .foregroundColor(Color.white)
          .background(Color.blue)
          .cornerRadius(8)
          
          Button(action: {
            service.sendMove(Move(moveUp: false, moveDown: true))
          }) {
            HStack{
              Text("Down")
              .padding(.horizontal)
            }
            .padding()
          }
          .frame(width: 200, height: 60, alignment: .center)
          .foregroundColor(Color.white)
          .background(Color.blue)
          .cornerRadius(8)
          
          Button(action: {
            isShowAR = true
          }) {
            HStack{
                Text("AR thing")
                  .padding(.horizontal)
            }
            .padding()
          }
          .frame(width: 200, height: 60, alignment: .center)
          .foregroundColor(Color.white)
          .background(Color.blue)
          .cornerRadius(8)
        }
        .background(
          NavigationLink(destination: ARViewContainer().edgesIgnoringSafeArea(.all), isActive: $isShowAR){
            EmptyView()
          }
            .hidden()
        )
      }
    }
}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView()
    }
}
