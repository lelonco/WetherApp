//
//  WetherDetailsCard.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct WetherDetailsCard: View {
    var wether: WetherResponse

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .shadow(color: .blue.opacity(0.3), radius: 20, x: 0, y: 0)
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                WetherDetails(wether: wether)
                    .padding()
            }
        }
        .frame(maxHeight: .infinity)
    }
}

struct WetherDetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        WetherDetailsCard(wether: previewWeather)
    }
}
