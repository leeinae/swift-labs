//
//  HomeViewController.swift
//  flexlayout-labs
//
//  Created by Inae Lee on 2023/06/28.
//

import UIKit

class HomeViewController: UIViewController {
    private let mainView = HomeView()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
