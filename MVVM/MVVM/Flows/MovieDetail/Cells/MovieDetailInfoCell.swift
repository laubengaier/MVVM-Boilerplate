//
//  MovieDetailCell.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit

class MovieDetailInfoCell : UITableViewCell {
    
    static let reuseIdentifier = "MovieDetailInfoCell"
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        view.textColor = .white
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 10
        view.textColor = UIColor.white.withAlphaComponent(0.75)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(contentView).inset(20)
        }
        
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(contentView).inset(20)
            make.leading.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(titleLabel.snp.width).offset(100)
            make.bottom.equalTo(contentView).inset(20).priority(999)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        infoLabel.text = nil
    }
    
}
