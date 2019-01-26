//
//  IncreaseAction.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

struct IncreaseAction: Action {
    let payload: Int
    init(payload: Int = 1) {
        self.payload = payload
    }
}
