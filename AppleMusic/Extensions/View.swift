//
//  View.swift
//  AppleMusic
//
//  Created by Osaretin Uyigue on 6/4/23.
//

import SwiftUI

extension View {
    /// Returns the current device's rounded corner radius
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0
    }
}
