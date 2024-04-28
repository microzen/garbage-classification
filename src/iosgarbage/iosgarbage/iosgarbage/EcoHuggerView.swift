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

struct RankingView: View {
    @State private var userRankings: [UserRanking] = [
        UserRanking(id: 1, name: "Jerry", points: 800, imageName: "jerry", rankChange: nil),
        UserRanking(id: 2, name: "Kayla", points: 570, imageName: "kayla", rankChange: nil),
        UserRanking(id: 3, name: "Matthew", points: 480, imageName: "matthew", rankChange: nil),
        UserRanking(id: 4, name: "Isabella", points: 442, imageName: "isa", rankChange: .up),
        UserRanking(id: 5, name: "Jenny", points: 385, imageName: "jenny", rankChange: .up),
        UserRanking(id: 6, name: "Sean", points: 326, imageName: "sean", rankChange: .down),
        UserRanking(id: 7, name: "Kevin", points: 211, imageName: "kevin", rankChange: .down)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Eco-Huggers")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    // Action for invite button
                }) {
                    Text("Invite")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            List(userRankings) { userRanking in
                HStack {
                    if let rankChange = userRanking.rankChange {
                        Image(systemName: rankChange == .up ? "arrow.up" : "arrow.down")
                            .foregroundColor(rankChange == .up ? .green : .red)
                    }
                    Image(userRanking.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    VStack(alignment: .leading) {
                        Text(userRanking.name)
                            .fontWeight(.bold)
                        Text("\(userRanking.points) points")
                            .font(.caption)
                    }
                    Spacer()
                    Text("\(userRanking.id)")
                        .padding(.all, 8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .padding(.vertical)
            }
            .listStyle(.plain)
            
            Spacer()
            
            // Add the bottom ZStack from previous examples here...
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}

