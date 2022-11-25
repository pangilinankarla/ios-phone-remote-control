import SwiftUI
import CodeScanner

struct LoginView: View {
  @EnvironmentObject var service: SocketService
  @StateObject private var viewModel = LoginViewModel()
  @State private var username: String = ""
  @State private var sessionId: String = ""
  @State private var selectedImage: UIImage?
  @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
  @State private var isShowingScanner = false
  @State private var isShowingImageSourceOption = false
  @State private var isShowingImagePicker = false
  @State private var pushAR = false

  var body: some View {
    ZStack {
      VStack(spacing: 18) {
        Text("Join a Meeting")
          .font(.title)
        VStack {
          if let selectedImage {
            Image(uiImage: selectedImage)
              .resizable()
              .scaledToFit()
              .frame(width: 120)
            Text("Click to change avatar")
          } else {
            Image(systemName: "person.crop.circle.badge.plus")
              .resizable()
              .scaledToFit()
              .frame(width: 120)
            Text("Click to add avatar")
          }
        }
        .foregroundColor(.gray)
        .onTapGesture {
          isShowingImageSourceOption = true
        }
        LoginField(
          title: "Username",
          text: $username
        )
        Divider()
        LoginField(
          title: "Session Id",
          text: $sessionId
        )
        Button("Join With Session Id") {
          Task {
            service.joinRoom("12345abc")

            pushAR = true
            
            viewModel.login(
              LoginRequest(
                username: username,
                sessionId: sessionId
              )
            )
          }
        }
        Divider()
        Button("Scan Qr Code") {
          isShowingScanner = true
        }
        NavigationLink(
          destination: ARFaceView().environmentObject(service),
          isActive: self.$pushAR) {
          EmptyView()
        }.hidden()
      }
      .padding()
      .buttonStyle(.borderedProminent)

      if viewModel.loginViewState.isLoading { LoadingDialog() }
    }
    .sheet(isPresented: $isShowingScanner) {
      CodeScannerView(
        codeTypes: [.qr],
        simulatedData: "prasetya@pras.com",
        completion: handleScan)
    }
    .sheet(isPresented: $isShowingImagePicker) {
      ImagePickerView(selectedImage: $selectedImage, sourceType: sourceType)
    }
    .confirmationDialog("Select Image Source", isPresented: $isShowingImageSourceOption) {
      Button("Camera") {
        sourceType = .camera
        isShowingImageSourceOption = false
        isShowingImagePicker = true
      }
      Button("Photo Library") {
        sourceType = .photoLibrary
        isShowingImageSourceOption = false
        isShowingImagePicker = true
      }
    }
  }

  func handleScan(result: Result<ScanResult, ScanError>) {
    isShowingScanner = false
    switch result {
    case .success(let result):
      print(result.string)
      viewModel.login(
        LoginRequest(
          username: username,
          sessionId: result.string))
    case .failure(let error):
      print("Scanning failed: \(error.localizedDescription)")
    }
  }


}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
