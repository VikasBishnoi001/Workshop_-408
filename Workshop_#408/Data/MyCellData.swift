//
//  MyCellData.swift
//  Workshop_#408
//
//  Created by Leewayhertz on 13/10/23.
//

import Foundation
import UIKit

class MyCellData {
    
    static func getMyAllData() -> [MyCellModel] {
        var myData = [MyCellModel]()
        myData = APIController().fetchData()
        
        
        return myData
        
    }
}
 
