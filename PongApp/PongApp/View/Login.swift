//
//  Home.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct Login: View {
  
  @State var email = ""
  @State var password = ""
  @Binding var isLoggedIn: Bool
  
    var body: some View {
      VStack {
        Text("Sign In")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(Color("dark"))
          .kerning(1.9)
          .frame(maxWidth:.infinity, alignment: .leading)
        
        VStack(alignment: .leading, spacing: 8, content: {
          Text("Username")
            .fontWeight(.bold)
            .foregroundColor(.gray)
          
          TextField("contoh@gmail.com", text: $email)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color("dark"))
            .padding(.top,5)
          
          Divider()
        })
        .padding(.top, 25)
        
        VStack(alignment: .leading, spacing: 8, content: {
          Text("Password")
            .fontWeight(.bold)
            .foregroundColor(.gray)
          
          SecureField("123456", text: $password)
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(Color("dark"))
            .padding(.top,5)
          
          Divider()
        })
        .padding(.top, 25)
        
        Button(action: {},label: {
          Text("Forgot password?")
            .fontWeight(.bold)
            .foregroundColor(.gray)
        })
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.top, 10)
        
        Button(action: {
          isLoggedIn = true
        }, label: {
          Image(systemName: "arrow.right")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .background(Color("dark"))
            .clipShape(Circle())
            .shadow(color: Color("lightBlue").opacity(0.6), radius: 5, x: 0, y: 0)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 10)
      }
      .padding()
    }
}

struct Login_Previews: PreviewProvider {
  @State static var isLoggedIn: Bool = false
    static var previews: some View {
      Login(isLoggedIn: $isLoggedIn)
    }
}
