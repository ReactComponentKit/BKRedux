//
//  CachePostware.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import RxSwift

extension ViewModel {
    func cache(state: State, action: Action) -> Observable<State> {
        return Single.create(subscribe: { (single) -> Disposable in
            guard let mystate = state as? MyState else {
                single(.success(state))
                return Disposables.create()
            }
            
            UserDefaults.standard.set(mystate.count, forKey: "count")
            UserDefaults.standard.synchronize()
            single(.success(mystate))
            
            return Disposables.create()
        }).asObservable()
    }
}
