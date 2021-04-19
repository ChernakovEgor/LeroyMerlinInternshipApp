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
        Section(title: "Недавно просмотренные", type: "recent", items: Item.recentItems),
        Section(title: "Предложение ограничено", type: "limited", items: Item.limitedItems),
        Section(title: "Лучшая цена", type: "best", items: Item.bestItems)
    ]
}

struct Item: Hashable {
    let id: String
    let title: String
    let price: Int
    let image: UIImage
    
    static let categories: [Item] = [
        Item(id: UUID().uuidString, title: "Каталог", price: 0, image: UIImage(named: "brick")!),
        Item(id: UUID().uuidString, title: "Сад", price: 0, image: UIImage(named: "plant")!),
        Item(id: UUID().uuidString, title: "Освещение", price: 0, image: UIImage(named: "chandelier")!),
        Item(id: UUID().uuidString, title: "Инструменты", price: 0, image: UIImage(named: "drill")!),
        Item(id: UUID().uuidString, title: "Строй-\nматериалы", price: 0, image: UIImage(named: "brick")!),
        Item(id: UUID().uuidString, title: "Декор", price: 0, image: UIImage(named: "roll")!),
        Item(id: UUID().uuidString, title: "Смотреть всё", price: 0, image: UIImage(named: "brick")!),
    ]
    
    static let bestItems: [Item] = [
        Item(id: UUID().uuidString, title: "Минимойка Sterwins 135, 135 бар, 420 л/ч, 2 кВт", price: 7430, image: UIImage(named: "vacuum")!),
        Item(id: UUID().uuidString, title: "Салфетка, 35x35 см, микрофибра, 4 шт.", price: 122, image: UIImage(named: "rags")!),
        Item(id: UUID().uuidString, title: "Очиститель для стёкол Clean Glass 600 мл", price: 78, image: UIImage(named: "cleaner")!),
        Item(id: UUID().uuidString, title: "Штукатурка механизированная гипсовая Knauf МП 75 Мастер 30 кг", price: 337, image: UIImage(named: "knauf")!),
        Item(id: UUID().uuidString, title: "Бетоносмеситель Калибр «Земляк» БСЭ-200, 200 л", price: 14338, image: UIImage(named: "mixer")!),
    ]
    
    static let limitedItems: [Item] = [
        Item(id: UUID().uuidString, title: "Дрель-шуруповерт бесщеточная Metabo BS18LTXBLI, 18 В Li-ion 2х4 Ач", price: 50341, image: UIImage(named: "drill")!),
        Item(id: UUID().uuidString, title: "Пескобетон Axton 30 кг", price: 143, image: UIImage(named: "concrete")!),
        Item(id: UUID().uuidString, title: "Экструдированный пенополистирол Т-15 50 мм 585х1185 мм 0.69 м²", price: 232, image: UIImage(named: "plank")!),
        Item(id: UUID().uuidString, title: "Утеплитель Роквул Стандарт 50 мм 5.4 м²", price: 654, image: UIImage(named: "wool")!),
        Item(id: UUID().uuidString, title: "Тачка садовая двухколесная усиленная 320 кг/100 л", price: 2881, image: UIImage(named: "cart")!),
    ]
    
    static let recentItems: [Item] = [
        Item(id: UUID().uuidString, title: "Лопата штыковая Fiskars SolidTM 116 см сталь с черенком", price: 807, image: UIImage(named: "shovel")!),
        Item(id: UUID().uuidString, title: "Спанбонд белый в рулоне, 60 г/м2, 3,2х25 м", price: 1300, image: UIImage(named: "roll-1")!),
        Item(id: UUID().uuidString, title: "Шланг для полива Gardena Basic ø19 мм 25 м, ПВХ", price: 1890, image: UIImage(named: "hose")!),
        Item(id: UUID().uuidString, title: "Бак садовый для мусора 240 л", price: 3861, image: UIImage(named: "bin")!),
        Item(id: UUID().uuidString, title: "Насос погружной дренажный Sterwins CDW-3 для грязной воды, 11000 л/час", price: 2990, image: UIImage(named: "pump")!),
    ]
}
