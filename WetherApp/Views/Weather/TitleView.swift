//
//  TitleView.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct TitleView: View {
    var wether: WetherResponse
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(wether.name ?? "City name")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .font(.title2)
                .fontWeight(.light)
                .foregroundColor(.white)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(wether: previewWeather)
    }
}
