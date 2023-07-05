//
//  ContentView.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI
import SwiftKeychainWrapper
import Firebase

struct ContentView: View {
    @State private var selection = 3
    @ObservedObject var contentModel = ContentViewModel(retrievable: ExternalRestRetriever())

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: self.$selection) {
                    Group {
                        if self.contentModel.contentViewModel.loggedIn == true {
                            SearchView()
                                .tabItem {
                                    Label("Search", systemImage: "magnifyingglass")
                                }
                                .tag(2)
                            FeedCombinationView()
                                .tabItem {
                                    Label("Feed", systemImage: "person.2.fill")
                                }
                                .tag(3)
                            ProfileView()
                                .tabItem {
                                    Label("Profile", systemImage: "person")
                                }
                                .tag(4)
                        } else {
                            FeedView(onlyFollowing: false)
                                .tabItem {
                                    Label("Explore", systemImage: "network")
                                }
                                .tag(1)
                            LoginView()
                                .tabItem {
                                    Label("Login", systemImage: "person.badge.key.fill")
                                }
                                .tag(2)
                        }
                    }
                    .toolbar(.visible, for: .tabBar)
                    .toolbarBackground(Style.AppColor, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarColorScheme(.dark, for: .tabBar)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Style.AppColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        HStack {
                            Image("Logo_no_bg")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundColor(.white)
                                .padding([.bottom, .top])
                        }
                    }
                }
            }
        }
        .task {
            await self.contentModel.reload()
        }
        .preferredColorScheme(.light)
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    // Get URL components from the incoming user activity.
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
        return false
    }

    // Check for specific URL components that you need.
    guard let path = components.path,
    let _ = components.queryItems else {
        return false
    }
    print("path = \(path)")

    // Dispatch event to trigger another view
    return true
}
