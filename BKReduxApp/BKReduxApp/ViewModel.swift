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
    
    let count = Output<String>(value: "0")
    let color = Output<UIColor>(value: UIColor.white)
    let progress = Output<Float>(value: 0.0)
    
    override init() {
        super.init()
        
        // STORE
        store.set(
            initialState: MyState(),
            middlewares: [
                printCacheValue,
                progress,
                consoleLogMiddleware
            ],
            reducers: [
                countReducer,
                colorReducer
            ],
            postwares: [
                cachePostware
            ]
        )
    }
    
    override func on(newState: MyState) {
        count.accept(String(newState.count))
        color.accept(newState.color)
        progress.accept(newState.progress)
    }
    
    override func on(error: Error, action: Action) {
        
    }
    
    deinit {
        print("[## deinit ##]")
    }
}
