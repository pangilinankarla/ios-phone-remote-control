import SwiftUI

struct LoginField: View {
  let title: String
  @Binding var text: String
  var body: some View {
    TextField(title, text: $text)
      .autocapitalization(.none)
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 4)
          .fill(Color.gray.opacity(0.1))
      }
  }
}

struct LoginField_Previews: PreviewProvider {
  static var previews: some View {
    LoginField(
      title: "text",
      text: .constant("")
    )
  }
}
