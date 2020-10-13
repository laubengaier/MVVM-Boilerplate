//
//  DashboardVC.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class DashboardVC : UIViewController {

    let viewModel: DashboardVM
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    init(viewModel: DashboardVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "Dashboard"
        view.backgroundColor = .systemRed
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let data = Observable<[String]>.just(["first element", "second element", "third element"])

        data.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, model, cell in
          cell.textLabel?.text = model
        }
        .disposed(by: disposeBag)
    }
    
}
