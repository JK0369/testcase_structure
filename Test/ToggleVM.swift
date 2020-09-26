//
//  ToggleVM.swift
//  TestCodeMVVM
//
//  Created by 김종권 on 2020/09/26.
//  Copyright © 2020 jongkwon kim. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ToggleVM: ViewModel {

    let bag = DisposeBag()

    struct Input {
        var didTapBtnToggle: Observable<Void>
    }

    struct Output {
        var toggleCount: Driver<Int>
    }

    func transform(input: Input) -> Output {
        let toggleCount = BehaviorRelay(value: 0)

        input.didTapBtnToggle.bind(onNext: { _ in
            toggleCount.accept(toggleCount.value + 1)
        }).disposed(by: bag)

        return Output(toggleCount: toggleCount.asDriver(onErrorJustReturn: 0))
    }
}
