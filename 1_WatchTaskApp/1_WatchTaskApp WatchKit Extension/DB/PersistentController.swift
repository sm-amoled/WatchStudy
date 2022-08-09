//
//  PersistentController.swift
//  1_WatchTaskApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/01.
//

import Foundation
import CoreData

struct PersistentController {
    
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        // 일반적으로 컨테이너의 name은 DB 데이터모델 파일의 이름과 같다.
        // 나는 파일 명이 "doit.xcdatamodeld"이므로, 이름을 "doit"으로 넣어주었다.
        container = NSPersistentContainer(name: "doit")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDesc, error in
            if let error = error as NSError? {
                fatalError("Failed to load container \(error.localizedDescription)")
            }
        }
    }
}
 
