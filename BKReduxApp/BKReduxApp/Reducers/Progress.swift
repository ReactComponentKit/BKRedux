//
//  LoopMiddleware.swift
//  BKReduxApp
//
//  Created by burt on 2018. 12. 7..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import RxSwift

extension ViewModel {
    func progress(state: State, action: Action) -> Observable<State> {
        guard var mutableState = state as? MyState else { return .just(state) }
        
        switch action {
        case is StartProgressAction:
            mutableState.stopProgress = false
            mutableState.progress = 0.0
            nextDispatch(action: ProgressAction(), applyNewState: true)

        case is StopProgressAction:
            mutableState.stopProgress = true
            
        case is CompleteProgressAction:
            mutableState.stopProgress = true
            nextDispatch(action: IncreaseAction(), applyNewState: true)
            
        case is ProgressAction:
            if mutableState.stopProgress == false {
                mutableState.progress += 0.01
                if mutableState.progress > 1.0 {
                    nextDispatch(action: CompleteProgressAction(), applyNewState: true)
                } else {
                    nextDispatch(action: ProgressAction(), applyNewState: true)
                    Thread.sleep(forTimeInterval: 0.1)
                    let progress = mutableState.progress
                    mutableState = store.state
                    mutableState.progress = progress
                }
            }

        default:
            break
        }
        
        return .just(mutableState)
    }
}
