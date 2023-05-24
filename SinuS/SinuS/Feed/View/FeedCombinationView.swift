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
    let numTabs = 2
    
    var body: some View {
        VStack {
            HStack {
                if (self.selection == 0){
                    Text("Following").foregroundColor(Style.TextOnColoredBackground)
                    Button("Explore"){
                        self.selection = 1
                    }.foregroundColor(.gray)
                }
                else{
                    Button("Following"){
                        self.selection = 0
                    }.foregroundColor(.gray)
                    Text("Explore").foregroundColor(Style.TextOnColoredBackground)
                }
            }
            .padding(.top)
            TabView(selection: self.$selection) {
                Group{
                    FeedView(onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "person.2.fill")
                        }
                        .tag(0)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                    FeedView(onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "network")
                        }
                        .tag(1)
                        .highPriorityGesture(DragGesture().onEnded({
                            self.handleSwipe(translation: $0.translation.width)
                        }))
                }
            }
            .animation(.easeOut(duration: 0.2), value: selection)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Color(.systemGroupedBackground))
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .tabBar)
        .background(Style.AppBackground)
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
