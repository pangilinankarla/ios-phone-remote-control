import SwiftUI

struct LoadingDialog: View {

  var body: some View {
    VStack {
      Spacer()
      ProgressView()
        .padding()
        .background {
          RoundedRectangle(cornerRadius: 4)
            .fill(.white)
        }
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background {
      Color.black.opacity(0.6)
    }
  }
}

struct LoadingDialog_Previews: PreviewProvider {
  static var previews: some View {
    LoadingDialog()
  }
}
