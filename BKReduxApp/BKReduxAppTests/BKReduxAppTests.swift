//
//  BKReduxAppTests.swift
//  BKReduxAppTests
//
//  Created by burt on 2018. 7. 29..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import BKReduxApp

class TestValue {
    
}

class BKReduxAppTests: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCount() {
        let expectation = self.expectation(description: "testCount")
        let scheduler = TestScheduler(initialClock: 10)
        let disposeBag = DisposeBag()
        let viewModel = ViewModel()
    
        let dispatchActions: TestableObservable<Action> = scheduler.createHotObservable([
            .next(1, IncreaseAction(payload: 3)),
            .next(2, IncreaseAction(payload: 10)),
            .next(3, DecreaseAction()),
            .next(4, DecreaseAction())
        ])
        
        dispatchActions.bind { (action) in
            viewModel.dispatch(action: action)
        }.disposed(by: disposeBag)
        
        let observer = scheduler.createObserver(String.self)
        
        viewModel.output.count.asDriver().drive(onNext: { (value) in
            observer.onNext(value)
            if observer.events.count == dispatchActions.recordedEvents.count + 1 {
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        let _ = scheduler.start(disposed: 500) {
            return dispatchActions.asObservable()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(observer.events.count, 5)
            XCTAssertEqual(viewModel.output.count.value, "11")
        }
    }
    
}
