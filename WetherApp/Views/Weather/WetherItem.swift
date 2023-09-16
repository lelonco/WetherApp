//
//  WetherItem.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//

import SwiftUI

struct WetherItem: View {
    let imageName: String
    let title: String
    let text: String
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .foregroundColor(.gray)
                Image(systemName: imageName)
                    .foregroundColor(.white)
            }
            .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body)
                Text(text)
                    .font(.title2)
            }
        }
    }
}

struct WetherItem_Previews: PreviewProvider {
    static var previews: some View {
        WetherItem(imageName: "thermometer.medium", title: "Min temp", text: "10")
    }
}
