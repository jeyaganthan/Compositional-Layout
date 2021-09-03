//
//  Bundle-Decodable.swift
//  Compotitional Layout Example
//
//  Created by Jeyaganthan's Mac Mini on 03/09/21.
//

import Foundation

extension Bundle {
    
    /// This Generic function to convert the json data to Respective data Model
    /// - Parameters:
    ///   - type: Generic Data
    ///   - file: file Path
    /// - Returns: Respective data Type
    func decode<T: Decodable>(_ type : T.Type , from file :String ) -> T {
        guard let fileURL = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load url from \(file) bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed load data \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed convert data \(data) from bundle")
        }
        
        return loadedData
    }
}
