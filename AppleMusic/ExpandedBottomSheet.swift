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
                dragIndicator()
                    .opacity(animateContent ? 1 : 0)
                
                /// Artwork with Hero Animation
                GeometryReader {
                    let size = $0.size
                    
                    MusicArtworkImageView(image: "p2", size: size, cornerRadius: 15)
                }
                .matchedGeometryEffect(id: "ARTWORK", in: animation)
                .frame(height: size.width - 50)
                
            }
            .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
            .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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

struct ExpandedBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
