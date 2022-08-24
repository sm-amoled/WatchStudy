//
//  HeartRateView.swift
//  HeartRateApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/23.
//

import SwiftUI
import HealthKit

struct HeartRateView: View {
    
    let heartRateViewModel = HeartRateViewModel()
    
    var body: some View {
        VStack{
            HStack{
                Text("❤️")
                    .font(.system(size: 50))
                Spacer()
                
            }
            
            HStack{
                Text("\(heartRateViewModel.heartRateText)")
                    .fontWeight(.regular)
                    .font(.system(size: 70))
                
                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .padding(.bottom, 28.0)
                
                Spacer()
                
            }
            
        }
        .padding()
    }
}

struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView()
    }
}
