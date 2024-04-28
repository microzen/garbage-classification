import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false

    var body: some View {
        ZStack{
            Image("logo") // Make sure you have a 'logo' image in your assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(y:-300)
                    .offset(x:-90)
                    .onAppear {
                        print("Logo image appears")
                    }
            VStack {
                
                Spacer()
                Text("Welcome Back !")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 30)
                
                Text("Please enter your details.")
                    .font(.body)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .shadow(radius: 1)
                    .padding(.horizontal, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .shadow(radius: 1)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                HStack {
                    Button(action: {
                        self.rememberMe.toggle()
                    }) {
                        HStack {
                            Image(systemName: rememberMe ? "checkmark.square" : "square")
                            Text("Remember for 30 days")
                        }
                    }
                    Spacer()
                    Button(action: {
                        // Forgot password action
                    }) {
                        Text("Forgot password")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 20)

                Button(action: {
                    // Login action
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 140/255, green: 174/255, blue: 94/255))
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
                .padding(.top, 20)

                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            .edgesIgnoringSafeArea(.all)
        }
        }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
