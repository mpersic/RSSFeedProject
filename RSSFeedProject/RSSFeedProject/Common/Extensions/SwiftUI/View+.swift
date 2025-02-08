//
//  View+.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

extension View {
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
