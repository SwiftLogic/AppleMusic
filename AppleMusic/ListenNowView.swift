//
//  ListenNowView.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct ListenNowView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    createCardView("Card 1")
                    createCardView("Card 2")
                }
                .padding()
                .padding(.bottom, 100)
            }
            .navigationTitle("Listen Now")
        }
    }
    
    @ViewBuilder
    private func createCardView(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
    }
}

struct ListenNowView_Previews: PreviewProvider {
    static var previews: some View {
        ListenNowView()
    }
}
