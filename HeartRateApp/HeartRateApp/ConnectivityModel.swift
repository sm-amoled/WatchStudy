//
//  ConnectivityModel.swift
//  HeartRateApp
//
//  Created by Park Sungmin on 2022/08/23.
//

import Foundation
import WatchConnectivity

class ConnectivityModel : NSObject,  ObservableObject, WCSessionDelegate {

    
    static let shared = ConnectivityModel()
    
    var session: WCSession
    
    private init(session: WCSession = .default) {
        self.session = session
        super.init()
        
        self.session.delegate = self
        session.activate()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    // iOS와 WatchOS의 연결(세션)시도 이후에 실행되는 함수
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    // 상대편에서 보낸 메시지를 받을 때 사용하는 함수. 실질적으로 제일 많이 사용한다.
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        //        let getMessage = message["message"] as? String ?? ""
        
        if WCSession.isSupported() {
            print(WCSession.default.receivedApplicationContext)
            if let sendedWord = ConnectivityModel.shared.session.receivedApplicationContext["action"] as? String {
                print(sendedWord)
                // "start" 명령을 받고, workOut Session이 진행중이지 않을 때 새로운 Session 시작
                if sendedWord == "start" {
//                    self.delegate?.startWorkout()
                } else if sendedWord == "stop" {
//                    self.delegate?.stopWorkout()
                } else {
                    print("No Action Type")
                }
            }
        } else {
            print("error")
        }
    }
}
