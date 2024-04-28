import SwiftUI
import MapKit

struct MapViewControllerWrapper: View {
    @State private var showingMap = false
    @State private var showingRank = false
    @State private var showingHome = false // State to control navigation to the home page
    let mylocation = CLLocationCoordinate2D(latitude: 38.541755, longitude: -121.759575)

    var body: some View {
        
        

        
        NavigationView {
            TabView {
                MapView(location: mylocation)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }

                HomePage()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                RewardsViewInMap()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Rewards")
                    }
            }
            .overlay(
                BottomBarInMap(showingMap: $showingMap, showingRank: $showingRank, showingHome: $showingHome),
                alignment: .bottom
            )
        }
    }
}

struct BottomBarInMap: View {
    @Binding var showingMap: Bool
    @Binding var showingRank: Bool
    @Binding var showingHome: Bool

    var body: some View {
        HStack {
            Button(action: {
                self.showingMap = true // Trigger map showing, adapt with actual navigation if needed
            }) {
                Image("carbon_map")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .padding(.leading, 45)

            Spacer()

            // This button is now purely decorative as NavigationLink triggers navigation
            NavigationLink(destination: UploadImageView(), isActive: $showingHome) {
                Image("mdi_leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
            }
            .padding(.trailing, 40)
            .offset(x: 27)

            Spacer()

            NavigationLink(destination: RewardsView(), isActive: $showingRank) {
                           Image("rank_grey2")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 40, height: 40)
                       }
                       .padding(.trailing, 40)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 80)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
        .offset(y: 33)
    }
}

struct MapView: View {
    let location: CLLocationCoordinate2D
    let station1 = CLLocationCoordinate2D(latitude: 38.549503, longitude: -121.718102)
    let station2 = CLLocationCoordinate2D(latitude: 38.670727, longitude: -121.727959)
    let station3 = CLLocationCoordinate2D(latitude: 38.672582, longitude: -121.767605)
    let station4 = CLLocationCoordinate2D(latitude: 38.680488, longitude: -121.752287)
    let station5 = CLLocationCoordinate2D(latitude: 38.447819, longitude: -121.822338)
    let station6 = CLLocationCoordinate2D(latitude: 38.528112, longitude: -121.966389)

    var body: some View {
        Map(){
            Marker("station1", coordinate: station1)
            Marker("station2", coordinate: station2)
            Marker("station3", coordinate: station3)
            Marker("station4", coordinate: station4)
            Marker("station5", coordinate: station5)
        }
            .edgesIgnoringSafeArea(.all)
    }
}

struct HomePage: View {
    var body: some View {
        Text("Home Page")
    }
}

struct RewardsViewInMap: View {
    var body: some View {
        Text("Rewards Page")
    }
}

struct MapViewControllerWrapper_Previews: PreviewProvider {
    static var previews: some View {
        MapViewControllerWrapper()
    }
}
