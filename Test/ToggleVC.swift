//
//  ToggleVC.swift
//  TestCodeMVVM
//
//  Created by 김종권 on 2020/09/26.
//  Copyright © 2020 jongkwon kim. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class ToggleVC: UIViewController {

    @IBOutlet weak var btnToggle: UIButton!
    @IBOutlet weak var lblCount: UILabel!

    let bag = DisposeBag()
    let viewModel = ToggleVM()

    private lazy var input = ToggleVM.Input(didTapBtnToggle: self.btnToggle.rx.tap.asObservable())
    private lazy var output = self.viewModel.transform(input: input)

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        output.toggleCount
            .map { String($0) }
            .drive(lblCount.rx.text)
            .disposed(by: bag)
    }
}
