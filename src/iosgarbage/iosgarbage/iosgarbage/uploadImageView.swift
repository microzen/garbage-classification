import SwiftUI

struct UploadImageView: View {
    // State variables to handle image picker
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            Text("Upload Your Image")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)

            Text("We will advise the correct bin & earn your EcoCoin!")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()

            Spacer()

            // Illustration or image placeholder
            Image("recycle_illustration") // Replace with your actual image name
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            Spacer()

            // Upload Image Button
            Button(action: {
                // This will toggle the showingImagePicker to true
                self.showingImagePicker = true
            }) {
                Text("Upload Image")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                // ImagePicker() is a struct you will need to define using UIKit's UIImagePickerController
            }

            Spacer()

            // Your decorative graphics at the bottom
            Image("decorative_leaf") // Replace with your actual image name
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding(.bottom)
        }
        .navigationTitle("Upload Image") // Used when this view is within a NavigationView
        .navigationBarTitleDisplayMode(.inline)
    }

    func loadImage() {
        // Handle the image picked from the image picker
    }
}

// ImagePicker struct to handle selecting an image
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.inputImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}
