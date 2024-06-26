//
//  StorageManager.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/11/24.
//

import Foundation

class StorageManager<T: Codable>{
    let tripSaveData : [tripSaveStruct]?
    
    init() {
        let fileUrl = URL.documentsDirectory.appendingPathComponent("save.json")
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            
            do {
                let content = try Data(contentsOf: fileUrl)
                let decoder = JSONDecoder()
                tripSaveData = try decoder.decode([tripSaveStruct].self, from: content)
                
                
            } catch {
                print(error)
                tripSaveData = nil
            }
            
            return
        } else {
            tripSaveData = nil
        }

    }
        
        func save(components : [tripSaveStruct]) {
            let encoder = JSONEncoder()
            let url = URL.documentsDirectory.appendingPathComponent("save.json")
            do {
                let data = try encoder.encode(components)
                try data.write(to: url)
            } catch {
                print(error)
            }
            
        }
    }
