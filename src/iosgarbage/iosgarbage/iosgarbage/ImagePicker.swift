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
                    // Couldn't read the file.
                    return nil
                }
            }
            print("\(fileName) not exist")
            return nil
        }
        func uploadFile(fileName: String, fileExtension: String, endpoint: String) {
            let fileNameWithExtension = fileName + "." + fileExtension
            let url = URL(string: endpoint)

            var data = Data()
            
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString

            let session = URLSession.shared

            // Set the URLRequest to POST and to the specified URL
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"

            // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
            // And the boundary is also set here
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            // Add the file data to the raw http request data
        //    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        //    data.append("Content-Disposition: form-data; name=\"name\"; username=\"kemal\"\r\n".data(using: .utf8)!)
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"file\"; filename=\"recieved\(fileExtension)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: \"content-type header\"\r\n\r\n".data(using: .utf8)!)

            print("opening file...")
            if let bytes: [UInt8] = getFile(fileName: fileNameWithExtension) {
                for byte in bytes {
                    data.append(byte)
                }
            

            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                if error == nil {
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                    if let json = jsonData as? [String: Any] {
                        print(json)
                    }
                }
            }).resume()
        }
        }

        

    }
    
   
}
