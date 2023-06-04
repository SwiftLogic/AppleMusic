//
//  MusicInfoView.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct MusicInfoView: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 0) {
            /// Matched Geo Hero Animation
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        MusicArtworkImageView(image: "p2", size: size, cornerRadius: expandSheet ? 15 : 5)
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


struct MusicInfoView_Previews: PreviewProvider {
    static var previews: some View {
       HomeView()
    }
}
