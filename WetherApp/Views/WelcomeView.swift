//
//  WelcomeView.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI
import CoreLocationUI
struct WelcomeView: View {
    @EnvironmentObject var viewMoidel: WeatherViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Welcome to the Wether App")
                    .bold()
                    .font(.title)
                    .padding()
                    .multilineTextAlignment(.center)
                Text("Please share your current location")
                    .padding()
            }
            
            LocationButton(.shareCurrentLocation) {
                viewMoidel.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
