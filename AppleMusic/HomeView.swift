//
//  HomeView.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct HomeView: View {
    @State private var expandSheet = false
    @Namespace private var animation

    var body: some View {
        TabView {
            TabItemButton(title: "Listen Now", systemName: "play.circle.fill", expandSheet: expandSheet)
            TabItemButton(title: "Browse", systemName: "square.grid.2x2.fill", expandSheet: expandSheet)
            TabItemButton(title: "Radio", systemName: "dot.radiowaves.left.and.right", expandSheet: expandSheet)
            TabItemButton(title: "Music", systemName: "play.square.stack", expandSheet: expandSheet)
            TabItemButton(title: "Search", systemName: "magnifyingglass", expandSheet: expandSheet)
        }
        .tint(Color.red)
        .safeAreaInset(edge: .bottom) {
            CustomBottomSheet(expandSheet: $expandSheet, animation: animation)
        }
        .overlay {
            if expandSheet {
                ExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
                /// Fluent Transition Animation
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
}

private struct TabItemButton: View {
    let title: String
    let systemName: String
    let expandSheet: Bool
    
    var body: some View {
        /// iOS Bug, It can be Avoided by wrapping the view inside ScrollView
        ScrollView(showsIndicators: false) {
            Text(title)
                .padding(.top, 25)
        }
        .tabItem {
            Image(systemName: systemName)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
