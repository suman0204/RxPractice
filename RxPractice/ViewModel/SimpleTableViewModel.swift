//
//  SimpleTableViewModel.swift
//  RxPractice
//
//  Created by 홍수만 on 2023/11/02.
//

import Foundation
import RxSwift

class SimpleTableViewModel {
    
    let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
}
