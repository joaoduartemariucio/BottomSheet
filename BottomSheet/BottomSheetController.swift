//
//  BottomSheetController.swift
//  BottomSheet
//
//  Created by João Vitor Duarte Mariucio on 01/16/19.
//  Copyright © 2019 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

class BottomSheetController: UIViewController {
    
    let fullView: CGFloat = 100
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 325
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arredondarCantosSuperiores()
        self.setupLayoutController()
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height - 100)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        view.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:))))
    }

    func setupLayoutController(){
        //Setting layout components
    }
    
    func arredondarCantosSuperiores(){
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 25, height: 25)).cgPath
        self.view.layer.mask = maskLayer
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)

        let y = self.view.frame.minY
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )

            duration = duration > 1.25 ? 1 : duration

            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
            })
        }
    }
}
