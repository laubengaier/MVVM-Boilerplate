//
//  InfoVC.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import Foundation
import UIKit
import SwiftUI

class InfoVC : UIViewController {
    
    let viewModel: InfoVM
    
    lazy var contentView = UIHostingController(rootView: InfoView(viewModel: viewModel))
    
    init(viewModel: InfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.didMove(toParent: self)
        
        contentView.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}

class SwiftUIViewController : UIViewController {
    
    let viewModel: InfoVM
    
    lazy var contentView = UIHostingController(rootView: InfoView(viewModel: viewModel))
    
    init(viewModel: InfoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { return nil }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.didMove(toParent: self)
        contentView.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}
