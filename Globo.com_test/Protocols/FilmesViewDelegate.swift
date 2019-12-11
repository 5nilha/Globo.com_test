//
//  FilmesViewDelegate.swift
//  Globo.com_test
//
//  Created by Fabio Quintanilha on 12/10/19.
//  Copyright © 2019 FabioQuintanilha. All rights reserved.
//

import Foundation

protocol FilmesViewDelegate {
    func filmesDidLoad()
    func filmesDidUpdate()
}

extension FilmesViewDelegate {
    func filmesDidLoad(){}
    func filmesDidUpdate(){}
}
