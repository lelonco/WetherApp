//
//  CompactWetherView.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct CompactWetherView: View {
    var wether: WetherResponse

    var body: some View {
        HStack(alignment: .center) {
            
            VStack(spacing: 10) {
                if let icon = wether.weather?.first?.icon {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { image in
                        image
                            .resizable()
                            .font(.system(size: 50))
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        LoadingView()
                    }
                }
                Text("Clear")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)

            }
            .frame(width: 150, alignment: .leading)
            Spacer()
            Text(wether.temp?.toDegreeString() ?? "")
                .font(.system(size: 100))
                .foregroundColor(.white)

        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .padding()

    }
}

struct CompactWetherView_Previews: PreviewProvider {
    static var previews: some View {
        CompactWetherView(wether: previewWeather)
    }
}
