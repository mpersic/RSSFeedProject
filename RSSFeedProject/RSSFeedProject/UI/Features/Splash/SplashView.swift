//
//  SplashPage.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import Factory
import SwiftUI

struct SplashView: View {

    @InjectedObject(\.splashVM) private var vm

    var body: some View {
        if vm.isFinished {
            MainView()
        } else {
            Image(systemName: Images.newspaper)
                .resizable()
                .scaledToFit()
                .frame(height: vm.iconHeight)
        }
    }
}

#Preview {
    SplashView()
}
