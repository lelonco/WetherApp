//
//  CompactWetherCard.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct CompactWetherCard: View {
    var wether: WetherResponse

    var body: some View {
        VStack {
            CompactWetherView(wether: wether)

            Image("city")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 300)
        }
    }
}

struct CompactWetherCard_Previews: PreviewProvider {
    static var previews: some View {
        CompactWetherCard(wether: previewWeather)
    }
}
