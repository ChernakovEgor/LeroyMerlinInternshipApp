//
//  SelfConfiguringCell.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 17.04.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reusableIdentifier: String { get }
    func configure(for item: Item)
}
