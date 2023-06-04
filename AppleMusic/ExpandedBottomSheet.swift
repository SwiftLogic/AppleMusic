//
//  ExpandedBottomSheet.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct ExpandedBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animateContent = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        Rectangle()
                            .fill(Color("BG"))
                            .opacity(animateContent ? 1 : 0)
                    }
                    .overlay(alignment: .top) {
                        MusicInfoView(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false) /// Disabling interaction
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15) {
                    dragIndicator()
                        .opacity(animateContent ? 1 : 0)
                    
                    /// Artwork with Hero Animation
                    GeometryReader {
                        let size = $0.size
                        MusicArtworkImageView(image: "p2", size: size, cornerRadius: 15)
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    .frame(height: size.width - 50)
                    
                    PlayerView(mainSize: size)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandSheet = false
                        animateContent = false
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .all)

        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    @ViewBuilder
    private func dragIndicator() -> some View {
        Capsule()
            .fill(.gray)
            .frame(width: 40, height: 5)
    }
}


private struct PlayerView: View {
    let mainSize: CGSize
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            /// Dynamic Spacing Using Available Height
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    musicTextInfo()
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func musicTextInfo() -> some View {
        HStack(alignment: .center, spacing: 15) {
            musicTitleLabels()
            optionsButton()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func musicTitleLabels() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Look What You Made Me do")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Taylor Swift")
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func optionsButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.white)
                .padding(12)
                .background {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                }
        }
    }
    
}


struct ExpandedBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
