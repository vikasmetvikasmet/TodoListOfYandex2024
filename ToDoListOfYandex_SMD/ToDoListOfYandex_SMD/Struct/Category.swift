//
//  Category.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 06.07.2024.
//

import Foundation


struct Category{
    let name: String
    let hexColor: String
}

class CategoryModel{
    private (set) var categories: [Category] = [
        Category(name: "Учеба", hexColor: "230c98"), //фиолетовый
        Category(name: "Работа", hexColor: "e120fe"), // розовый
        Category(name: "Спорт", hexColor: "20b2aa"), //бирюзовый
        Category(name: "Хобби", hexColor: "8bca84"), //зеленый
        Category(name: "Другое", hexColor: "fff68f") //желтый
    ]
    func add(with category: Category) {
        categories.append(category)
    }
}
