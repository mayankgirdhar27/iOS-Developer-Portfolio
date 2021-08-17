//
//  PassCodeModel.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 20/06/2021.
//

import Foundation
import SwiftUI

struct PassCodeViewData: Identifiable {
    var id: Int
    var row: [PassCodeViewRows]
}
struct PassCodeViewRows: Identifiable {
    
    var id: Int
    var value: String
    
}
var PassCodeNumData = [
    PassCodeViewData(id: 0, row:
                        [PassCodeViewRows(id: 0, value: "1"),PassCodeViewRows(id: 1, value: " 2"),PassCodeViewRows(id: 2, value: "3")]),
    PassCodeViewData(id: 1, row:
                        [PassCodeViewRows(id: 0, value: "4"),PassCodeViewRows(id: 1, value: "5"),PassCodeViewRows(id: 2, value: "6")]),
    PassCodeViewData(id: 2, row:
                        [PassCodeViewRows(id: 0, value: "7"),PassCodeViewRows(id: 1, value: "8"),PassCodeViewRows(id: 2, value: "9")]),
    PassCodeViewData(id: 3, row:
                        [PassCodeViewRows(id: 0, value: "xmark.circle.fill"),PassCodeViewRows(id: 1, value: "0"),PassCodeViewRows(id: 2, value: "    ")])
]
