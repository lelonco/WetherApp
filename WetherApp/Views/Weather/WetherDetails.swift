//
//  WetherDetails.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct WetherDetails: View {
    var wether: WetherResponse

    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            Text("Wether now")
            
            HStack {
                VStack(alignment: .leading) {
                    WetherItem(imageName: "thermometer.medium", title: "Min temp", text: wether.tempMin?.toDegreeString() ?? "")
                    WetherItem(imageName: "wind", title: "Pressure", text: wether.pressure?.roundDouble() ?? "")
                }
                Spacer()
                VStack(alignment: .leading) {
                    WetherItem(imageName: "thermometer.high", title: "Max temp", text: wether.tempMax?.toDegreeString() ?? "")
                    WetherItem(imageName: "humidity", title: "Humidity", text: wether.humidity?.roundDouble() ?? "")
                }
            }
            Spacer()
        }
    }
}

struct WetherDetails_Previews: PreviewProvider {
    static var previews: some View {
        WetherDetails(wether: previewWeather)
    }
}
