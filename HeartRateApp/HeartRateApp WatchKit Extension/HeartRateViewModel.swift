//
//  HeartRateViewModel.swift
//  HeartRateApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/23.
//

import Foundation
import SwiftUI
import HealthKit
import WatchConnectivity

class HeartRateViewModel: WKInterfaceController {
    var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")

    @State var heartRateValue: Double? = 0
    @State var heartRateText: String = ""

    var workSession: HKWorkoutSession!
    var builder: HKLiveWorkoutBuilder!

    var isRunning = false
    
    override init() {
        print("hello")
        super.init()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    
    override func willActivate() {
        super.willActivate()
        
        // WCSesssion 초기화, InterfaceController를 Delegate로 지정
        if isSupported() {
            ConnectivityModel.shared.delegate = self
            ConnectivityModel.shared.session.activate()
        }
    }
    
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
//    func authorizeHealthKit() {
//        let healthKitTypes: Set = [
//            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
//        ]
//
//        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
//    }
    
    private func updateLabel(statistics: HKStatistics?) {
        
        guard let statistics = statistics else {
            return
        }
        
        DispatchQueue.main.async {
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            self.heartRateValue = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit)
            self.heartRateText = "\(Int(self.heartRateValue ?? 0)) BPM"
            
            if self.isReachable() {
                do {
                    print(self.heartRateValue ?? "nil Heart Rate")
                    try ConnectivityModel.shared.session.updateApplicationContext(["request":self.heartRateValue ?? "- -"])
                } catch {
                    print("error")
                }
            } else {
                print("Not Reachable")
            }
        }
    }
    
    private func runWorkOut() {
        authorization { (success, healthkit) in
            
            self.healthStore =  healthkit;
            
            if success {
                
                // WorkOut 세션 활용
                let configuration = HKWorkoutConfiguration()
                configuration.activityType = .running
                configuration.locationType = .outdoor
                
                do {
                    // WorkOut 세션 선언 후
                    self.workSession = try HKWorkoutSession(healthStore: self.healthStore, configuration: configuration)
                    self.builder = self.workSession.associatedWorkoutBuilder()
                    
                } catch {
                    
                    return
                }
                self.workSession.delegate = self
                self.builder.delegate = self
                
                // WorkOut 세션의 데이터 주기적으로 전달 선언
                self.builder.dataSource = HKLiveWorkoutDataSource(healthStore: self.healthStore,
                                                                  workoutConfiguration: configuration)
                self.workSession.startActivity(with: Date())
                self.builder.beginCollection(withStart: Date()) { (success, error) in
                    
                }
            }
        }
    } 
    
    private func stopWorkOut() {
        if workSession != nil {
            workSession.end()

            builder.endCollection(withEnd: Date()) { (success, error) in
                self.builder.finishWorkout { (workout, error) in
                    
                }
            }
        }
    }
    
    
    
    private func isSupported() -> Bool {
        return WCSession.isSupported()
    }
    
    
    private func isReachable() -> Bool {
        return ConnectivityModel.shared.session.isReachable
    }
}


// MARK: - Workout Builder Delegate
extension HeartRateViewModel: HKLiveWorkoutBuilderDelegate {
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            updateLabel(statistics: statistics)
        }
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }
}


// MARK: - Workout Session  Delegate
extension HeartRateViewModel: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
    }
    
    func handle(_ workoutConfiguration: HKWorkoutConfiguration){
        print("start");
    }
    
    
}


extension HeartRateViewModel: ConnectivityModelDelegate {
    func startWorkout() {
        self.isRunning = true
    }
    
    func stopWorkout() {
        self.isRunning = false
    }
}
