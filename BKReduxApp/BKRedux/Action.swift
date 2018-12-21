//
//  Action.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

public protocol Action {
    
}

public struct VoidAction: Action {
    public init() {
    }
}

public struct NextDispatch {
    let action: Action
    let applyNewState: Bool
    
    init(action: Action, applyNewState: Bool = false) {
        self.action = action
        self.applyNewState = applyNewState
    }
}
