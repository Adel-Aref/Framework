//
//  Models.swift
//  MVVMEx
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
struct Students: Codable {
    let status :String?
    let data: [Student]?
    
}

struct Student: Codable,Equatable {
    let studentId: Int?
    let studentName: String
}
