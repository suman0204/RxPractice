//
//  SimpleTableViewController.swift
//  RxPractice
//
//  Created by 홍수만 on 2023/10/31.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimpleTableViewController: UIViewController {
    
    let viewModel = SimpleTableViewModel()
    
    let tableView = {
        let view = UITableView()
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure View
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

//        let items = Observable.just(
//            (0..<20).map { "\($0)" }
//        )
        
        viewModel.items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
//            .subscribe(onNext:  { value in
//                
//                let alertView = UIAlertController(title: "RxExample", message: "Tapped `\(value)`", preferredStyle: .alert)
//                alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
//                })
//                self.present(alertView, animated: true, completion: nil)
//                
//            })
            .subscribe(with: self, onNext: { owner, value in
                
                owner.presentAlert("Tapped `\(value)`")
                
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
//            .subscribe(onNext: { indexPath in
//                
//                let alertView = UIAlertController(title: "RxExample", message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)", preferredStyle: .alert)
//                alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
//                })
//                self.present(alertView, animated: true, completion: nil)
//                
////                DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
//            })
            .subscribe(with: self, onNext: { owner, indexPath in
                
                owner.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
                
            })
            .disposed(by: disposeBag)
    }
    

    
}

extension SimpleTableViewController {
    private func presentAlert(_ message: String) {
        
        let alertView = UIAlertController(title: "RxExample", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
        })
        self.present(alertView, animated: true, completion: nil)
        
    }
}
