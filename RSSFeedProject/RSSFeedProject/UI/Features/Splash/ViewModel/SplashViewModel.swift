//
//  SplashViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import SwiftUI

class SplashViewModel : ObservableObject{
    @Published var isFinished: Bool = false
    let iconHeight: CGFloat = 200
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut) {
                self.isFinished = true
            }
        }
    }
}
