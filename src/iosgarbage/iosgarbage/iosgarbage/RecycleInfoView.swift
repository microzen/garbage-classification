import SwiftUI

struct RecycleInfoView: View {
    var topImage: UIImage
    var objectName: String
    var descriptionText: String
    var material: String
    var saveCO2: String
    var ecoCoinValue: String
    
    var body: some View {
        VStack {
            Image(uiImage: topImage)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image("detect")
                    Text(objectName) // Object name
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 204/255, green: 220/255, blue: 183/255))
                .cornerRadius(10)
                
                Text(descriptionText) // Description
                    .padding(.horizontal)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
                
            Spacer()
            
            VStack {
                Text("RECYCLABLE ITEM")
                    .font(.headline)
                    .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                    .padding(.top)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Material")
                        Text("Save CO2")
                        Text("EcoCoin")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                    .padding(.leading, 10)
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text(material) // Material
                        Text(saveCO2) // Save CO2 value
                        Text(ecoCoinValue) // EcoCoin value
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                    .padding(.trailing, 10)
                }
                .padding()
                .cornerRadius(20)
                .padding(.bottom)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 64/255, green: 119/255, blue: 89/255), lineWidth: 1) // You can adjust lineWidth to make the border thicker
            )
        
            
            Spacer(minLength: 45)
            
            Button("Okie, I got it") {
                // Action for button press
            }
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color(red: 140/255, green: 174/255, blue: 94/255))
            .cornerRadius(10)
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(20)
        .padding()
    }
}

// This preview will not work without concrete UIImage and values, so you'll need to provide them in your actual implementation
struct RecycleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleInfoView(
            topImage: UIImage(named: "demoCan")!,
            objectName: "Detected a can",
            descriptionText: "Ensure it is empty and rinse it out if possible, then recycle it without crushing, checking local guidelines to confirm specific requirements!",
            material: "Aluminum",
            saveCO2: "1.3 kg",
            ecoCoinValue: "+5"
        )
    }
}

