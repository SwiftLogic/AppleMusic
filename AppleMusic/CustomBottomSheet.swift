//
//  CustomBottomSheet.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

struct CustomBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    private let defaultTabBarHeight: CGFloat = 49.0

    var body: some View {
        ZStack {
            /// Animating Sheet Background (To Look Like It's Expanding From the Bottom)
            if expandSheet {
                Rectangle().fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(MusicInfoView(expandSheet: $expandSheet,
                                           animation: animation))
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
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

struct CustomBottomSheet_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CustomBottomSheet(expandSheet: .constant(true), animation: namespace)
    }
}
