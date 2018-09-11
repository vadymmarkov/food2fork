//
//  Navigator.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}
