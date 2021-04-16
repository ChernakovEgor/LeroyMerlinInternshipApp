//
//  Data.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import Foundation
import UIKit

struct Item {
    var title: String
    var price: Int
    var image: UIImage
    
    static var items: [Item] = [
        Item(title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
    ]
}
