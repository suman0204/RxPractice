//
//  SimplePickerViewController.swift
//  RxPractice
//
//  Created by 홍수만 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimplePickerViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let picker1 = {
        let view = UIPickerView()
        return view
    }()
    
    let picker2 = {
        let view = UIPickerView()
        return view
    }()
    
    let picker3 = {
        let view = UIPickerView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //configure View
        [picker1, picker2, picker3].forEach {
            view.addSubview($0)
        }
        
        picker1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        picker2.snp.makeConstraints { make in
            make.top.equalTo(picker1.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        picker3.snp.makeConstraints { make in
            make.top.equalTo(picker2.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        Observable.just([1, 2, 3])
            .bind(to: picker1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        picker1.rx
            .modelSelected(Int.self)
            .subscribe { value in
                print("model selected 1: \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: picker2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)

        picker2.rx
            .modelSelected(Int.self)
            .subscribe { value in
                print("model selected 2: \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: picker3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        picker3.rx
            .modelSelected(UIColor.self)
            .subscribe { value in
                print("model selected 3: \(value)")
            }
            .disposed(by: disposeBag)
        
    }
}
