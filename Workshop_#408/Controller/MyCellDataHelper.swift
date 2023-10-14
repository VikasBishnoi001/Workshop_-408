//
//  MyCellDataHelper.swift
//  Workshop_#408
//
//  Created by Leewayhertz on 13/10/23.
//

import Foundation

class APIController {
    
    func fetchData() -> [MyCellModel] {
        var myData = [MyCellModel]()
        let semaphore = DispatchSemaphore(value: 0)

        if let url = URL(string: "https://jsonplaceholder.typicode.com/photos") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                defer {
                    semaphore.signal() // Signal the semaphore when the task is complete
                }
                
                guard let data = data, error == nil else {
                    print("Error Occurred While Accessing Data")
                    return
                }
                do {
                    myData = try JSONDecoder().decode([MyCellModel].self, from: data)
//                    print(myData)
                } catch {
                    print("Error While Decoding JSON into Swift Structure \(error)")
                }
            }
            task.resume()
            
            semaphore.wait() // Wait for the task to complete before returning
        } else {
            print("Invalid URL")
        }
        
        return myData
    }
    
}
