//
//  ActorListVC.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 14.10.20.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Kingfisher

class ActorListVC : UIViewController {

    let viewModel: ActorListVM
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        return view
    }()
    
    init(viewModel: ActorListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "Actors"
        view.backgroundColor = .systemRed
        
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
    }
    
}
