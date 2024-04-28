import SwiftUI

struct UploadImageView: View {
    // State variables to handle image picker
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var pickerSourceType: PickerSourceType = .photoLibrary
    @State private var showingMap = false // State to control navigation to the map view
    @State private var navigateToRecycleInfo = false
    @State private var showingRank = false

    var body: some View {
        VStack() {
            Text("Upload Your Image")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)
                .offset(y:40)
            
            VStack{
                Text("Advise the correct bin & earn your ")
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundColor(.secondary)
                Text("EcoCoin!")
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundColor(.green)
                
                  
            }
            .padding()
            .offset(y:40)
            
            ZStack{
                Rectangle()
                .fill(Color.clear) // Makes the rectangle transparent
                .frame(width: 300, height: 200) // Set the size of the empty box
                .background(Color.white) // Set the background color
                .cornerRadius(20) // Adds rounded corners
                .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds the shadow
                .offset(y:100)
               
                
                Spacer() // Pushes everything to the center
                
                Image("trash") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .offset(y:-20)
                        .offset(x:5)
                        .onAppear {
                            print("Logo image appears")
                        }
                Spacer()
                Image("leaf2") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .offset(y:200)
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
                self.pickerSourceType = .photoLibrary  // You can toggle this to .camera if you want
                self.showingImagePicker = true
            }) {
                Text("Upload Image")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 150)
                    .background(Color.green)
                    .cornerRadius(20)
                    
            }
            .offset(y:-130)
            .padding(.horizontal, 40)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            CustomImagePicker(inputImage: $inputImage, sourceType: pickerSourceType)
                
            }

            Button(action: {
                // This will toggle the showingImagePicker to true
                self.navigateToRecycleInfo = true
            }) {
                Text("Result")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 150)
                    .background(Color.green)
                    .cornerRadius(20)
                    
            }
            .offset(y:-130)
            .padding(.horizontal, 40)
            .sheet(isPresented: $navigateToRecycleInfo, onDismiss: loadImage) {
                RecycleInfoView(
                    topImage: UIImage(named: "demoCan")!,
                    objectName: "Detected a can",
                    descriptionText: "Ensure it is empty and rinse it out if possible, then recycle it without crushing, checking local guidelines to confirm specific requirements!",
                    material: "Aluminum",
                    saveCO2: "1.3 kg",
                    ecoCoinValue: "+5"
                )
                
            }
            
            
            Spacer()
 
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width, height: 70)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                HStack {
                    Button(action: {
                            self.showingMap = true
                        }) {
                            Image("carbon_map")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                        .padding(.leading, 40)
                        .sheet(isPresented: $showingMap) {
                            MapViewControllerWrapper()
                                .previewDisplayName("Map View Controller")
                        }
                    Spacer()
                    Image("mdi_leaf")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .offset(x:20)
                    Spacer()
                    Button(action: {
                            self.showingRank = true
                        }) {
                            Image("rank_grey2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding(.trailing,40)
                        }
                        .padding(.leading, 40)
                        .sheet(isPresented: $showingRank) {
                            RewardsView()
                                .previewDisplayName("Map View Controller")
                        }
                    
                }
                .padding(.horizontal)
            }
            .offset(y:124)
            
            
            // Your decorative graphics at the bottom
            Image("decorative_leaf") // Replace with your actual image name
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding(.bottom)
        }
        .navigationTitle("Upload Image") // Used when this view is within a NavigationView
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.bottom)
        
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
