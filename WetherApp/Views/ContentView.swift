//
//  ContentView.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        guard let wether = viewModel.weather else {
            return firstScreen()
        }
        return AnyView(WetherView(wether: wether))
    }
    
    func firstScreen() -> AnyView {
        AnyView(
            VStack {
                if viewModel.location != nil {
                    ProgressView()
                        .task {
                            viewModel.getWeather()
                        }
                } else {
                    if viewModel.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(viewModel)
                    }
                }
            }
                .background(Color.gray)
                .preferredColorScheme(.dark)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

