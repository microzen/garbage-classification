import SwiftUI

struct Reward: Identifiable {
    let id = UUID()
    var storeName: String
    var coinsRequired: Int
    var discountDescription: String
}

struct RewardCell: View {
    var reward: Reward

    var body: some View {
        HStack {
            Image(reward.storeName.replacingOccurrences(of: " ", with: "_")
                                 .replacingOccurrences(of: "'", with: "")
                                 .lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(reward.storeName)
                    .font(.headline)
                Spacer(minLength: 5)
                Text(reward.discountDescription)
                    .font(.caption)
                    .foregroundStyle(Color(red: 64/255, green: 119/255, blue: 89/255))
            }
            
            Spacer()

            Button(action: {
                // Redeem reward action
            }) {
                Text("Use Now")
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

struct RewardsView: View {
    
    @State private var showingEcoRanker = false
    @State private var ecoCoins = 550
    @State private var rewards = [
        Reward(storeName: "Whole Foods", coinsRequired: 100, discountDescription: "Use 100 EcoCoins to get $10 offyour next purchase."),
        Reward(storeName: "Trader Joe's", coinsRequired: 50, discountDescription: "Redeem 50 EcoCoins to receive 10% off your next grocery bill."),
        Reward(storeName: "Albertsons", coinsRequired: 40, discountDescription: "Get $3 off freshly baked goodswhen you redeem 40 EcoCoins."),
        Reward(storeName: "Amazon", coinsRequired: 150, discountDescription: "Use 150 EcoCoins to get $10 off onselected eco-friendly products.")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Green stack for "Rewards" and "Rank"
            ZStack {
                Rectangle()
                    .fill(Color(red: 140/255, green: 174/255, blue: 94/255))
                    .edgesIgnoringSafeArea(.top)

                HStack {
                    Text("Rewards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle rank action
                        self.showingEcoRanker = true
                        
                    }) {
                        HStack {
                            Image("rank_star")
                            Text("Rank")
                    
                        }
                        .foregroundColor(Color(red: 64/255, green: 119/255, blue: 89/255))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                        .sheet(isPresented: $showingEcoRanker) {
                            RankingView()
                        }
                    }
                }
                .padding()
            }
            .frame(height: 60)
            Spacer(minLength: 40)
            // EcoCoins card
            HStack {
                Image("EcoCoin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                
                Text("EcoCoins")
                    .font(.body)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(ecoCoins)")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
            }
            .padding()
            .background(Color(red: 140/255, green: 174/255, blue: 94/255))
            .cornerRadius(10)
            .padding(.horizontal)
            .shadow(radius: 1)
            
            // Divider
            Spacer(minLength: 25)
            Rectangle()
            .fill(Color(red: 64/255, green: 119/255, blue: 89/255)) // Set the color of the divider
            .frame(height: 2) // Set the height of the divider
            .padding(.horizontal)
            Spacer(minLength: 25)
            
            // Rewards list
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(rewards) { reward in
                        RewardCell(reward: reward)
                    }
                }
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .overlay(
            VStack {
                Spacer()
                customBottomBar
            }, alignment: .bottom
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

var customBottomBar: some View {
    ZStack {
        Rectangle()
            .fill(Color.clear)
            .frame(width: UIScreen.main.bounds.width, height: 70)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 5, x: 0, y: 2)
        HStack {
            
            
            Image("carbon_map")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.leading,40)
            
            Spacer()
            
            Image("grey_leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            
            
            Spacer()
            Image("rank_star")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.trailing,40)
        }
        .padding(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct BottomBar: View {
    var body: some View {
        ZStack{
            Rectangle()
            .fill(Color.clear) // Makes the rectangle transparent
            .frame(width: 100000, height: 70) // Set the size of the empty box
            .background(Color.white) // Set the background color
            .cornerRadius(20) // Adds rounded corners
            .shadow(color: .gray, radius: 5, x: 0, y: 2) // Adds the shadow
            .offset(y:190)
            HStack{
                Image("rank_grey2") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height:200)
                        .offset(y:185)
                        .offset(x:190)
                Image("mdi_leaf") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 200)
                        .offset(y:185)
                        .offset(x:0)
                Image("carbon_map") // Make sure you have a 'logo' image in your assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .offset(y:185)
                        .offset(x:-190)
            }
        
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
