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
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemPink
        return view
    }()
    
}
