//
//  MyTests.swift
//  TestTests
//
//  Created by 김종권 on 2020/09/26.
//  Copyright © 2020 jongkwon kim. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxNimble
import Nimble
import RxTest
@testable import Test

class MyTests: XCTestCase {

    var bag: DisposeBag!
    var scheduler: TestScheduler!
    var viewModel = ToggleVM()
    lazy var output = viewModel.transform(input: .init(didTapBtnToggle: didTapBtnToggle.asObservable()))

    var didTapBtnToggle: PublishSubject<Void>!

    // Given
    override func setUp() {
        bag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        viewModel = ToggleVM()
        didTapBtnToggle = PublishSubject<Void>()
    }

    func testAddCount() throws {
        // When
        scheduler.createColdObservable([
            .next(1, ()),
            .next(10, ()),
            .next(30, ()),
            ]).bind(to: didTapBtnToggle).disposed(by: bag)

        // Then
        expect(self.output.toggleCount).events(scheduler: scheduler, disposeBag: bag).to(equal([
            .next(0, 0),
            .next(1, 1),
            .next(10, 2),
            .next(30, 3),
        ]))
    }
}
