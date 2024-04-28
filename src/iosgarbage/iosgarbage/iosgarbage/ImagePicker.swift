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
                        let url = "http://127.0.0.1:5000/upload"  // Use http for local testing without SSL
                        print("Uploading to: \(url)")
                        uploadFile(fileName: filename.lastPathComponent, fileExtension: "jpg", endpoint: url)
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
            guard let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Document directory not found")
                return
            }

            let filename = docDirectory.appendingPathComponent("\(UUID().uuidString).jpg")
            
            // Convert image to JPEG data
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                do {
                    // Write to the file
                    try imageData.write(to: filename)
                    print("Image saved to: \(filename.path)")
                    
                } catch {
                    print("Error saving image: \(error)")
                }
            } else {
                print("Failed to convert image to JPEG data")
            }
        }

        
        
        func getFile(fileName: String) -> [UInt8]? {
            // See if the file exists.
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = dir.appendingPathComponent(fileName)
                do {
                    // Get the raw data from the file.
                    let rawData: Data = try Data(contentsOf: fileURL)
                    // Return the raw data as an array of bytes.
                    return [UInt8](rawData)
                } catch {
                    print("can't read!!")
                    print(fileURL)
                    // Couldn't read the file.
                    return nil
                }
            }
            print("\(fileName) not exist")
            return nil
        }
        func uploadFile(fileName: String, fileExtension: String, endpoint: String) {
            guard let url = URL(string: endpoint) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var data = Data()

            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)

            if let imageData = getFile(fileName: fileName) {
                data.append(contentsOf: imageData)
            } else {
                print("Failed to load image data")
                return
            }

            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
                if let error = error {
                    print("Error uploading: \(error.localizedDescription)")
                } else if let responseData = responseData {
                    print("Server Response: \(String(data: responseData, encoding: .utf8) ?? "No response data")")
                }
            }.resume()
        }


        

    }
    
   
}
