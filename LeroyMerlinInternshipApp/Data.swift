//
//  Data.swift
//  LeroyMerlinInternshipApp
//
//  Created by Egor Chernakov on 16.04.2021.
//

import Foundation
import UIKit

struct Section: Hashable {
    //let id: Int
    let title: String
    let type: String
    let items: [Item]
    
    static let sections: [Section] = [
        Section(title: "", type: "categories", items: Item.categories),
        Section(title: "Предложение ограничено", type: "limited", items: Item.limitedItems),
        Section(title: "Лучшая цена", type: "best", items: Item.bestItems)
    ]
}

struct Item: Hashable {
    let id: Int
    let title: String
    let price: Int
    let image: UIImage
    
    static let categories: [Item] = [
        Item(id: 10, title: "Каталог", price: 0, image: UIImage(named: "brick")!),
        Item(id: 11, title: "Материалы", price: 0, image: UIImage(named: "brick")!),
        Item(id: 12, title: "Каталог", price: 0, image: UIImage(named: "brick")!),
        Item(id: 13, title: "Каталог", price: 0, image: UIImage(named: "brick")!),
    ]
    
    static let bestItems: [Item] = [
        Item(id: 1, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 0, image: UIImage(named: "drill")!),
        Item(id: 2, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 1, image: UIImage(named: "drill")!),
        Item(id: 3, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 2, image: UIImage(named: "drill")!),
        Item(id: 7, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 3, image: UIImage(named: "drill")!),
        Item(id: 8, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 4, image: UIImage(named: "drill")!),
    ]
    
    static let limitedItems: [Item] = [
        Item(id: 4, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(id: 5, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(id: 6, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(id: 9, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(id: 10, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
    ]
}
