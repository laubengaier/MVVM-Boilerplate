//
//  MovieCell.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit

class MovieCell : UITableViewCell {
    
    static let reuseIdentifier = "MovieCell"
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()        
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(contentView)
            make.height.equalTo(150)
            make.bottom.equalTo(contentView).priority(999)
        }
        
        contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(contentView).inset(20)
            make.leading.equalTo(contentView).inset(20)
            make.width.equalTo(100)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieImageView.snp.top).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(20)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}