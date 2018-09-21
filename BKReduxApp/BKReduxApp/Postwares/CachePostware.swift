//
//  CachePostware.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

func cachePostware(state: State, action: Action) -> State {
    guard let mystate = state as? MyState else { return state }
    UserDefaults.standard.set(mystate.count, forKey: "count")
    UserDefaults.standard.synchronize()
    return mystate
}
