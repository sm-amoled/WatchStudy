//
//  OutlineView.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/09.
//

import SwiftUI

struct OutlineView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue, Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
            .padding()
    }
}

struct OutlineView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineView()
    }
}
