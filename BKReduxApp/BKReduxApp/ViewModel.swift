//
//  ViewModel.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 23..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MyState: State {
    var count: Int = 0
    var color: UIColor = UIColor.white
    var error: (Error, Action)? = nil
}

class ViewModel: ViewModelType<MyState> {
    
    let rx_count =  BehaviorRelay<String>(value: "0")
    let rx_color = BehaviorRelay<UIColor>(value: UIColor.white)
    
    override init() {
        super.init()

        // STORE
        store.set(
            initialState: MyState(),
            middlewares: [
                printCacheValue,
                consoleLogMiddleware
            ],
            reducers: [
                StateKeyPath(\MyState.count): countReducer,
                StateKeyPath(\MyState.color): colorReducer
            ],
            postwares: [
                cachePostware
            ]
        )
    }
    
    override func on(newState: MyState) {
        rx_count.accept(String(newState.count))
        rx_color.accept(newState.color)
    }
    
    override func on(error: Error, action: Action, onState: MyState) {
        
    }
    
    deinit {
        print("[## deinit ##]")
    }
}
