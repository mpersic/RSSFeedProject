//
//  SplashViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import SwiftUI

class SplashViewModel: BaseViewModel {
    @Published var isFinished: Bool = false
    let iconHeight: CGFloat = 200
    
    override init() {
        super.init()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut) {
                self.isFinished = true
            }
        }
    }
}
