



class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var parent: CustomImagePicker

    init(_ parent: CustomImagePicker) {
        self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.inputImage = uiImage
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}
