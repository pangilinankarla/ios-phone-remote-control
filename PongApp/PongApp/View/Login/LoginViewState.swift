import Foundation

struct LoginViewState: Equatable {
  static func == (lhs: LoginViewState, rhs: LoginViewState) -> Bool {
    return lhs.isLoading == rhs.isLoading
    && lhs.loginResult == rhs.loginResult
    && lhs.error?.localizedDescription == rhs.error?.localizedDescription
  }

  var isLoading: Bool = false
  var loginResult: Bool? = nil
  var error: Error? = nil
}
