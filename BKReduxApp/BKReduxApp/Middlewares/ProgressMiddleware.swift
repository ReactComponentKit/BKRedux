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
            nextDispatch(action: ProgressAction(), afterApplyNewState: true)

        case is StopProgressAction:
            mutableState.stopProgress = true
            nextDispatch(action: nil)
            
        case is CompleteProgressAction:
            mutableState.stopProgress = true
            nextDispatch(action: IncreaseAction())
            
        case is ProgressAction:
            if mutableState.stopProgress {
                nextDispatch(action: nil)
                break
            }
            
            mutableState.progress += 0.1
            if mutableState.progress > 1.0 {
                nextDispatch(action: CompleteProgressAction(), afterApplyNewState: true)
            } else {
                nextDispatch(action: ProgressAction(), afterApplyNewState: true)
                Thread.sleep(forTimeInterval: 0.1)
            }
        default:
            break
        }
        
        return .just(mutableState)
    }
}
