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
        return view
    }()
    
    lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()        
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .white
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        view.numberOfLines = 4
        view.textColor = UIColor.white.withAlphaComponent(0.5)
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
        contentView.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundImageView)
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
            make.trailing.equalTo(contentView).inset(20)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(movieImageView.snp.trailing).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.bottom.lessThanOrEqualTo(contentView).inset(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        movieImageView.image = nil
    }
    
}
