//
//  SearchListVC.swift
//  MVVM
//
//  Created by Mario Zimmermann on 14.10.20.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Kingfisher

class SearchListVC : UIViewController {

    let viewModel: SearchListVM
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        return view
    }()
    
    var searchController: UISearchController?
    
    init(viewModel: SearchListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "Suche"
        view.backgroundColor = .black
        
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
        
        guard let searchBar = self.searchController?.searchBar else { return }
    
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { (_) in
                print("Cancel Button tapped")
            })
            .disposed(by: self.disposeBag)
        
        searchBar.rx
            .text
            .map { _ in return searchBar.text ?? ""}
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [weak self] (query) in
                self?.viewModel.search(query: query.element ?? "")
            }
            .disposed(by: self.disposeBag)        
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
        .subscribe(onNext: { [weak self] (index) in
            self?.viewModel.showDetail(index: index.row)
        })
        .disposed(by: disposeBag)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.searchBar.placeholder = "Geben Sie hier etwas für die Suche ein"
        navigationItem.searchController = self.searchController
    }
    
}

extension SearchListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let _ = searchController.searchBar.text else { return }
        
    }
}
