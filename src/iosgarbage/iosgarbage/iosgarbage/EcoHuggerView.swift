import SwiftUI

struct UserRanking: Identifiable {
    let id: Int
    let name: String
    let points: Int
    let imageName: String
    let rankChange: RankChange?
    
    enum RankChange {
        case up
        case down
    }
}

struct HuggerCell: View {
    var ur: UserRanking

    var body: some View {
        HStack {
            if let rankChange = ur.rankChange {
                Image(systemName: rankChange == .up ? "arrow.up" : "arrow.down")
                    .foregroundColor(rankChange == .up ? .green : .red)
            }
            Image(ur.name.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            VStack() {
                Text(ur.name)
                    .fontWeight(.bold)
            }
            
            Spacer()

            Button(action: {
                // Redeem reward action
            }) {
                Text("\(ur.points) points")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical, 8) // Adjust vertical padding to make the button thinner
                    .padding(.horizontal, 5) // Adjust horizontal padding for width
                    .background(Color(red: 140/255, green: 174/255, blue: 94/255)) // Use the color set named 'ShadedGreen'
                    .cornerRadius(10)
            }
            .padding(.horizontal, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 1)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct RankingView: View {
    @State private var userRankings: [UserRanking] = [
//        UserRanking(id: 1, name: "Jerry", points: 800, imageName: "jerry", rankChange: nil),
//        UserRanking(id: 2, name: "Kayla", points: 570, imageName: "kayla", rankChange: nil),
//        UserRanking(id: 3, name: "Matthew", points: 480, imageName: "matthew", rankChange: nil),
        UserRanking(id: 4, name: "Isabella", points: 442, imageName: "isabella", rankChange: .up),
        UserRanking(id: 5, name: "Jenny", points: 385, imageName: "jenny", rankChange: .up),
        UserRanking(id: 6, name: "Sean", points: 326, imageName: "sean", rankChange: .down),
        UserRanking(id: 7, name: "Kevin", points: 211, imageName: "kevin", rankChange: .down)
    ]
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 140/255, green: 174/255, blue: 94/255))
                    .edgesIgnoringSafeArea(.top)
                HStack {
                    Text("Eco-Huggers")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    Image("arrow")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .offset(x: -232, y: -35)
                    Spacer()
                    Button(action: {
                    }) {
                        HStack {
                            Text("Invite")
                        }
                        .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                        .padding()
                        .padding(.vertical, -5) 
                        .padding(.horizontal, 5)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                    }
                }
                .padding()
            }
            .frame(height: 60)
            
            Spacer(minLength: 20)
            
            Image("lol")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            Spacer(minLength: 30)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(userRankings) { urs in
                        HuggerCell(ur: urs)
                    }
                }
            }
            
            Spacer()
        
        }
        .overlay(
            VStack {
                Spacer()
                customBottomBar
            }, alignment: .bottom
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
