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
import Kingfisher

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
        
        tableView.register(
            MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier
        )
        
        viewModel
        .data
        .bind(
            to: tableView.rx.items(cellIdentifier: MovieCell.reuseIdentifier)
        ) { index, model, cell in
            guard let cell = cell as? MovieCell else { return }
            cell.titleLabel.text = model.title
            cell.descriptionLabel.text = model.overview
            cell.movieImageView.kf.setImage(with: model.posterImageUrl, options: [.transition(.fade(0.4)), .forceTransition])
            cell.backgroundImageView.kf.setImage(with: model.backdropImageUrl, options: [.transition(.fade(0.4)), .forceTransition])
        }
        .disposed(by: disposeBag)
        
        tableView
        .rx
        .itemSelected
        .subscribe { [weak self] (index) in
            self?.viewModel.showDetail()
        }
        .disposed(by: disposeBag)

    }
    
}
