import Combine
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
  @Published var loginViewState: LoginViewState = LoginViewState()

  func login(_ loginRequest: LoginRequest) {
    loginViewState.isLoading = true
    //todo hit api to get the login data
    let varTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (varTimer) in
      self.loginViewState.isLoading = false
    }
  }
}

struct LoginRequest: Codable {
  var username: String
  var sessionId: String
}
