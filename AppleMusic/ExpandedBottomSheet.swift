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

    var body: some View {
        Text("Hello, World!")
        /// build grab indicator
    }
}

struct ExpandedBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
