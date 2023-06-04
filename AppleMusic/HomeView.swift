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
            TabItemButton(title: "Listen Now", systemName: "play.circle.fill")
            TabItemButton(title: "Browse", systemName: "square.grid.2x2.fill")
            TabItemButton(title: "Radio", systemName: "dot.radiowaves.left.and.right")
            TabItemButton(title: "Music", systemName: "play.square.stack")
            TabItemButton(title: "Search", systemName: "magnifyingglass")
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

private struct CustomBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    private let defaultTabBarHeight: CGFloat = 49.0

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThickMaterial)
                .overlay(MusicInfoView(expandSheet: $expandSheet,
                                       animation: animation))
        }
        .frame(height: 70)
        .overlay(alignment: .bottom) {
            lineSeperator()
        }
        .offset(y: -defaultTabBarHeight)
    }
}

extension CustomBottomSheet {
    @ViewBuilder
    private func lineSeperator() -> some View {
        Rectangle()
            .fill(.gray.opacity(0.3))
            .frame(height: 1)
            .offset(y: -5)
    }
}


private struct MusicInfoView: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 0) {
            /// Matched Geo Hero Animation
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        MusicArtworkImageView(image: "p2", size: size)
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                }
            }
            .frame(width: 45, height: 45)
            
            Text("Look What You Made Me do")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer()
            
            generateButton(for: "pause.fill")
            
            generateButton(for: "forward.fill")
                .padding(.leading, 25)

        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
    
    @ViewBuilder
    private func generateButton(for systemImage: String) -> some View {
        Button {
            //
        } label: {
            Image(systemName: systemImage)
                .font(.title2)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
