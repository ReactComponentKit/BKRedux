//
//  ColorReducer.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 28..
//  Copyright © 2018년 Burt.K. All rights reserved.
//


import RxSwift
import UIKit

extension ViewModel {
    func color(state: State, action: Action) -> Observable<State> {
        guard var mutableState = state as? MyState else { return .just(state) }
        
        if let act = action as? RandomColorAction {
            mutableState.color = act.payload
        }
        return .just(mutableState)
    }
}
