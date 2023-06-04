//
//  MusicArtworkImageView.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct MusicArtworkImageView: View {
    let image: String
    let size: CGSize
    let cornerRadius: CGFloat
    
    init(image: String, size: CGSize, cornerRadius: CGFloat = 5) {
        self.image = image
        self.size = size
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}
