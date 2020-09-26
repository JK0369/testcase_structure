//
//  ViewModel.swift
//  TestCodeMVVM
//
//  Created by 김종권 on 2020/09/26.
//  Copyright © 2020 jongkwon kim. All rights reserved.
//

import Foundation

protocol ViewModel: class {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
