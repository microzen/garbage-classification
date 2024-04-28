import SwiftUI

// Define an enum to specify the source type
enum PickerSourceType {
    case camera
    case photoLibrary
}

struct CustomImagePicker: UIViewControllerRepresentable {
    @Binding var inputImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var sourceType: PickerSourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        switch sourceType {
        case .camera:
            picker.sourceType = .camera
        case .photoLibrary:
            picker.sourceType = .photoLibrary
        }
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CustomImagePicker

        init(_ parent: CustomImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.inputImage = uiImage
                
                // Define the Documents directory path
                let fileManager = FileManager.default
                guard let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    print("Document directory not found")
                    parent.presentationMode.wrappedValue.dismiss()
                    return
                }

                // Generate a unique file name
                let filename = docDirectory.appendingPathComponent("\(UUID().uuidString).jpg")
                
                // Convert the image to JPEG data
                if let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                    do {
                        // Write the image data to the file system
                        try imageData.write(to: filename)
                        print("Image saved to: \(filename.path)")  // Print the full path
                    } catch {
                        print("Error saving image: \(error.localizedDescription)")
                    }
                } else {
                    print("JPEG data could not be created from UIImage.")
                }
            } else {
                print("No image found in picker response.")
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }

        
        func saveImageToDocumentsDirectory(image: UIImage) {
            let fileManager = FileManager.default
            let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let filename = docDirectory?.appendingPathComponent("\(UUID().uuidString).jpg")
            
            // Convert image to JPEG data
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                do {
                    // Write to the file
                    try imageData.write(to: filename!)
                    print("Image saved to: \(filename!)")
                } catch {
                    print("Error saving image: \(error)")
                }
            }
        }
    }
    
   
}
