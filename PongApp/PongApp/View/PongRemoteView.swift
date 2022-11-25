//
//  PongRemoteView.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import SwiftUI

struct PongRemoteView: View {
  @EnvironmentObject var service: SocketService
  private let gradient = Gradient(colors: [Color("color-dolly"), Color("color-astral")])
  
  var body: some View {
    ZStack {
      LinearGradient(
        gradient: gradient,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()

      connectionView
      movementView
    }
  }

  private var connectionView: some View {
    VStack {
      HStack(spacing: 20) {
        Button("Connect") {
          service.establishConnection()
        }
        .frame(width: 120, height: 30, alignment: .center)
        .foregroundColor(.white)
        .background(Color("color-astral"))
        .cornerRadius(8)
        
        Button("Disconnect") {
          service.closeConnection()
        }
        .frame(width: 120, height: 30, alignment: .center)
        .foregroundColor(.white)
        .background(Color("color-astral"))
        .cornerRadius(8)
      }
      Spacer()
    }
  }

  private var movementView: some View {
    VStack {
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
      .foregroundColor(.blue)
      .background(.white)
      .cornerRadius(8)
      
      Button(action: {
        service.sendMoveDown(Move(moveUp: false, moveDown: true))
      }) {
        HStack{
          Text("Down")
            .padding(.horizontal)
        }
        .padding()
      }
      .frame(width: 200, height: 60, alignment: .center)
      .foregroundColor(.blue)
      .background(.white)
      .cornerRadius(8)
    }
  }
}

struct PongRemoteView_Previews: PreviewProvider {
  static var previews: some View {
    PongRemoteView()
  }
}
