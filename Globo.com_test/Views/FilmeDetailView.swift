//
//  FilmeDetailView.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/7/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import UIKit


class FilmeDetailView: UIView {
    
    private var tapGesture: UITapGestureRecognizer!
    
    init(frame: CGRect, filme: FilmeViewModel) {
        super.init(frame: frame)
        self.setupView(filme: filme)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("View was deinitiated")
    }
    
    func setupView(filme: FilmeViewModel) {
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let popUpView = UIView()
        popUpView.sizeThatFits(CGSize(width: self.frame.size.width / 2, height: self.frame.size.height / 2))
        popUpView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        popUpView.backgroundColor = .black
        popUpView.roundBorder(radius: 8)
        self.addSubview(popUpView)
    }
    
    @objc func tapToDismiss() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
}
