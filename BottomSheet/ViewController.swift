//
//  ViewController.swift
//  BottomSheet
//
//  Created by João Vitor Duarte Mariucio on 01/16/19.
//  Copyright © 2019 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        addBottomSheetView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    func addBottomSheetView() {

        let bottomSheetVC = BottomSheetController()
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }

}
