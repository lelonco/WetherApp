//
//  WetherView.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct WetherView: View {
    var wether: WetherResponse
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                TitleView(wether: wether)
                CompactWetherCard(wether: wether)
                Spacer()
                WetherDetailsCard(wether: wether)
                    .ignoresSafeArea()
            }
        }

    }
}

struct WetherView_Previews: PreviewProvider {
    static var previews: some View {
        WetherView(wether: previewWeather)
    }
}
