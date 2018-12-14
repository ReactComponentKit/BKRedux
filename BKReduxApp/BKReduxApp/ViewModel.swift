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
    
    var stopProgress: Bool = false
    var progress : Float = 0.0
    var error: (Error, Action)? = nil
}

class ViewModel: ViewModelType<MyState> {
    
    struct Output {
        let count = BehaviorRelay<String>(value: "0")
        let color = BehaviorRelay<UIColor>(value: UIColor.white)
        let progress = BehaviorRelay<Float>(value: 0.0)
    }
    
    let output = Output()

    override init() {
        super.init()

        // STORE
        store.set(
            initialState: MyState(),
            middlewares: [
                //printCacheValue,
                progress,
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
        output.count.accept(String(newState.count))
        output.color.accept(newState.color)
        output.progress.accept(newState.progress)
    }
    
    override func on(error: Error, action: Action, onState: MyState) {
        
    }
    
    deinit {
        print("[## deinit ##]")
    }
}
