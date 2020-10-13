//
//  DashboardVC.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit

class DashboardVC : UIViewController {

    let viewModel: DashboardVM
    
    init(viewModel: DashboardVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "Dashboard"
        view.backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
