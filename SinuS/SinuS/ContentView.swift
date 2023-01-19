//
//  ContentView.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI
import SwiftKeychainWrapper

struct ContentView: View {
    static var AuthenticationToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""

    var body: some View {
        NavigationView {
            if KeychainWrapper.standard.string(forKey: "bearerToken") == nil {
                LoginView()
            } else {
                MenuView()
            }
        }
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
    let params = components.queryItems else {
        return false
    }
    print("path = \(path)")

    // Dispatch event to trigger another view
    return true
}
