import SwiftUI
import Combine


// Move the EventViewModel out of the ContentView struct.


struct ContentView: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
       
            VStack {
                
                Spacer()
                
                Image("logo1") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .onAppear {
                            print("Logo image appears")
                        }
                
                Spacer()
                
                // Event Data Text
                if !viewModel.eventData.isEmpty {
                    Text("Event Data: \(viewModel.eventData)")
                        .padding()
                }
                
                // Sign Up Button
                Button("Sign Up") {
                    // Handle sign up action
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.white)
                .background(Color(red: 140/255, green: 174/255, blue: 94/255))
                .cornerRadius(10)
                .padding(.horizontal, 50)
                
                // Log In Button
                Button("Log In") {
                    // Handle log in action
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
                
            }
            .onAppear {
                viewModel.fetchEvent()
            }
        }
        
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
