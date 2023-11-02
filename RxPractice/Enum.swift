//
//  Enum.swift
//  RxPractice
//
//  Created by 홍수만 on 2023/11/02.
//

import UIKit

enum ColorEnum {
    case red
    case green
    case blue
    
    var returnColor: UIColor {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        }
    }
}
