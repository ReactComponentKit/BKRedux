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
    func loop(state: State, action: Action) -> Observable<State> {
        guard action is StartProgressAction else { return .just(state) }
        
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            repeat {
                if strongSelf.store.state?.count == 10 {
                    break
                }
                Thread.sleep(forTimeInterval: 1)
                strongSelf.dispatch(action: IncreaseAction())
            } while true
        }
        
        return  Observable.just(state)
    }
}
