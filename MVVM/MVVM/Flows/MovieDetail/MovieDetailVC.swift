//
//  MovieDetailVC.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

class MovieDetailVC : UIViewController {

    let viewModel: MovieDetailVM
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        return view
    }()
    
    init(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "Detail"
        view.backgroundColor = .systemPurple
        navigationItem.largeTitleDisplayMode = .never
        
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
        
        tableView.delegate = self
        tableView.register(MovieDetailInfoCell.self, forCellReuseIdentifier: MovieDetailInfoCell.reuseIdentifier)
        
        viewModel
        .data
        .flatMap({ (movie) -> Observable<[(String, String)]> in
            guard let movie = movie else { return .just([]) }
            var details = [(String, String)]()
            details.append(("Title", movie.title + " | " + movie.originalTitle))
            details.append(("Overview", movie.overview))
            details.append(("Tags", movie.tagline))
            details.append(("Genres", String(movie.genres.map({ $0.name }).joined(separator: ", ")) ))
            return .just(details)
        })
        .bind(
            to: tableView.rx.items(cellIdentifier: MovieDetailInfoCell.reuseIdentifier)
        ) { index, model, cell in
            guard let cell = cell as? MovieDetailInfoCell else { return }
            cell.titleLabel.text = model.0
            cell.infoLabel.text = model.1
        }
        .disposed(by: disposeBag)
    }
    
}

extension MovieDetailVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = MovieDetailHeaderView()        
        if let imageUrl = viewModel.data.value?.backdropImageUrl {
            view.backgroundImageView.kf.setImage(with: imageUrl)
        }        
        return view
    }
    
}
