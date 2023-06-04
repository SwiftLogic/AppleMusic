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
                        MusicArtworkImageView(image: "p2", size: size, cornerRadius: expandSheet ? 15 : 5)
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    .frame(height: size.width - 50)
                    /// For Smaller Devices the padding will be 10 and for larger devices the padding will be 30
                    .padding(.vertical, size.height < 700 ? 10 : 30)
                    
                    PlayerView(mainSize: size)
                    /// Moving it from bottom
                        .offset(y: animateContent ? 0 : size.height)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
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
                    videoProgressView(padding: spacing)
                    videoTimerLabel()
                }
                .frame(height: size.height / 2.5, alignment: .top)
                videoPlaybackControls(size: size)
                    .frame(maxHeight: .infinity)

                VolumeView(padding: spacing, size: size)
                    .frame(height: size.height / 2.5, alignment: .bottom)

            }
        }
    }
    
    
    @ViewBuilder
    private func videoProgressView(padding: CGFloat) -> some View {
        Capsule()
            .fill(.ultraThinMaterial)
            .environment(\.colorScheme, .light)
            .frame(height: 5)
            .padding(.top, padding)
    }
    
    
    @ViewBuilder
    private func videoTimerLabel() -> some View {
        HStack {
            Text("0:00")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text("3:33")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func musicTextInfo() -> some View {
        HStack(alignment: .center, spacing: 15) {
            musicTitleLabels()
            Spacer()
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
    
    
    @ViewBuilder
    private func videoPlaybackControls(size: CGSize) -> some View {
        HStack(spacing: size.width * 0.18) {
            createPlayBackButton(for: "backward.fill", size: size)
            createPlayBackButton(for: "pause.fill", size: size, largeFont: .largeTitle, smallerFont: .system(size: 50))
            createPlayBackButton(for: "forward.fill", size: size)
        }
    }
    
    
    private func createPlayBackButton(for systemImage: String, size: CGSize,
                                      largeFont: Font = .title3,
                                      smallerFont: Font = .title) -> some View {
        Button {
            //
        } label: {
            Image(systemName: systemImage)
            ///Dynamic Sizing for smaller to larger iphones
                .font(size.height < 300 ? largeFont : smallerFont)
                .foregroundColor(.white)
        }

    }
    
}


private struct VolumeView: View {
    let padding: CGFloat
    let size: CGSize
    
    var body: some View {
        VStack(spacing: padding) {
            volumeSliderView()
            someTHIS()
        }
    }
    
    
    @ViewBuilder
    private func volumeSliderView() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "speaker.fill")
                .foregroundColor(.gray)
            
            Capsule()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .light)
                .frame(height: 5)
            
            Image(systemName: "speaker.wave.3.fill")
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func someTHIS() -> some View {
        HStack(alignment: .top, spacing: size.width * 0.18) {
            createButton(for: "quote.bubble")
            VStack(spacing: 6) {
                createButton(for: "airpods.gen3")
                Text("Samson's Airpods")
                    .font(.caption)
            }
            createButton(for: "list.bullet")
        }
        .foregroundColor(.white)
        .blendMode(.overlay)
        .padding(.top, padding)
    }
    
    @ViewBuilder
    private func createButton(for systemImage: String) -> some View {
        Button {
            
        } label: {
            Image(systemName: systemImage)
                .font(.title2)
        }
    }
}



struct ExpandedBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
