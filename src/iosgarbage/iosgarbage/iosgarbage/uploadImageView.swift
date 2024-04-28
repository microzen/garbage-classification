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
            
            HStack{
                Text("We will advise the correct bin & earn your ")
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundColor(.secondary) +
                Text("EcoCoin!")
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundColor(.green)
                  
            }
            .padding()
            
            ZStack{
                Rectangle()
                .fill(Color.clear) // Makes the rectangle transparent
                .frame(width: 300, height: 200) // Set the size of the empty box
                .background(Color.white) // Set the background color
                .cornerRadius(20) // Adds rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds the shadow
                .offset(y:80)
               
                
                Spacer() // Pushes everything to the center
                
                Image("trash") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(y:-50)
                        .offset(x:5)
                        .onAppear {
                            print("Logo image appears")
                        }
                Spacer()
                Image("leaf2") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .offset(y:170)
                        .offset(x:120)
                        .onAppear {
                            print("Logo image appears")
                        }
               
                
                // Illustration or image placeholder
//                Image("recycle_illustration") // Replace with your actual image name
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
            }
            
            
            

            Spacer()

            // Upload Image Button
            Button(action: {
                // This will toggle the showingImagePicker to true
                self.showingImagePicker = true
            }) {
                Text("Upload Image")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 150)
                    .background(Color.green)
                    .cornerRadius(20)
                    .offset(y:-160)
            }
            .padding(.horizontal, 40)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                // ImagePicker() is a struct you will need to define using UIKit's UIImagePickerController
            }

            Spacer()
            
            ZStack{
                Rectangle()
                .fill(Color.clear) // Makes the rectangle transparent
                .frame(width: 100000, height: 70) // Set the size of the empty box
                .background(Color.white) // Set the background color
                .cornerRadius(20) // Adds rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds the shadow
                .offset(y:160)
                HStack{
                    Image("leaf2") // Make sure you have a 'logo' image in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 200)
                            .offset(y:170)
                            .offset(x:120)
                    Image("leaf2") // Make sure you have a 'logo' image in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 200)
                            .offset(y:170)
                            .offset(x:140)
                    Image("leaf2") // Make sure you have a 'logo' image in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 200)
                            .offset(y:170)
                            .offset(x:70)
                }
            
            }
            
            
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
