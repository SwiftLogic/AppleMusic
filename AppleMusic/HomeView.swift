//
//  HomeView.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            TabItemButton(title: "Listen Now", systemName: "play.circle.fill")
            TabItemButton(title: "Browse", systemName: "square.grid.2x2.fill")
            TabItemButton(title: "Radio", systemName: "dot.radiowaves.left.and.right")
            TabItemButton(title: "Music", systemName: "play.square.stack")
            TabItemButton(title: "Search", systemName: "magnifyingglass")
        }
        .tint(Color.red)
    }
}

private struct TabItemButton: View {
    let title: String
    let systemName: String
    
    var body: some View {
        Text(title)
            .tabItem {
                Image(systemName: systemName)
                Text(title)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThickMaterial, for: .tabBar)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
