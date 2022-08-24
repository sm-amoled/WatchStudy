//
//  ContentView.swift
//  HeartRateApp
//
//  Created by Park Sungmin on 2022/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                sendStart()
            } label: {
                Text("Start")
            }
            
            Button {
                sendStop()
            } label: {
                Text("Stop")
            }
        }
    }
    
    func sendStart() {
        do {
            try ConnectivityModel.shared.session.updateApplicationContext(["action" : "start"])
        } catch {
            return
        }
    }
    
    func sendStop() {
        do {
            try ConnectivityModel.shared.session.updateApplicationContext(["action" : "stop"])
        } catch {
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    

}
