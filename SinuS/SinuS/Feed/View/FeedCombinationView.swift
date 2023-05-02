//
//  FeedCombinationView.swift
//  SinuS
//
//  Created by Loe Hendriks on 02/05/2023.
//

import SwiftUI

struct FeedCombinationView: View {
    @State private var selection = 1
    
    let minDragTranslationForSwipe: CGFloat = 50
    let numTabs = 3
    
    var body: some View {
        VStack {
            TabView(selection: self.$selection) {
                Group{
                    FeedView(onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "person.2.fill")
                        }
                        .tag(1)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                    FeedView(onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "network")
                        }
                        .tag(2)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                }
            }.animation(.easeOut(duration: 0.2), value: selection)
            .tabViewStyle(.page(indexDisplayMode: .never))  // <--- here
            .background(Color(.systemGroupedBackground))
        }.toolbar(.hidden, for: .tabBar)
            .toolbarBackground(.hidden, for: .tabBar)
        
            
    }
    
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selection > 0 {
            selection -= 1
        } else  if translation < -minDragTranslationForSwipe && selection < numTabs-1 {
            selection += 1
        }
    }
}

struct FeedCombinationView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCombinationView()
    }
}
