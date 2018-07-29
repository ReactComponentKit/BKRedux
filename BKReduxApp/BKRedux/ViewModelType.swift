//
//  ViewModelType.swift
//  ReactComponentKitApp
//
//  Created by burt on 2018. 7. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ViewModelType {
    // rx port
    public let rx_action = PublishSubject<Action>()
    public let rx_state = BehaviorRelay<[String:State]?>(value: nil)
    
    internal let store = Store()
    internal let disposeBag = DisposeBag()
    
    public init() {
        setupRxStream()
    }
    
    private func setupRxStream() {
        rx_action
            .flatMap(store.dispatch)
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: rx_state)
            .disposed(by: disposeBag)
        
        rx_state
            .subscribe(onNext: { [weak self] (newState) in
                if let (error, action) = newState?["error"] as? (Error, Action) {
                    self?.on(error: error, action: action)
                } else {
                    self?.on(newState: newState)
                }
            })
            .disposed(by: disposeBag)
    }
    
    internal func on(newState: [String:State]?) {
        
    }
    
    internal func on(error: Error, action: Action) {
        
    }
}
