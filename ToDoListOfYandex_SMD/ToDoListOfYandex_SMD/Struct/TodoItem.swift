//
//  TodoItem.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 23.06.2024.
//

import Foundation
import SwiftUI



struct TodoItem: Identifiable{
    let id: String
    let text: String
    let deadline: Date?
    let isDone: Bool
    let createdAt: Date
    let changedAt: Date?
    let priority: Priority
    let color: Color
    
    enum Priority: String{
        case low = "\u{2193}"
        case normal = ""
        case high = "\u{203C}"
    }
    


    init(
        id: String = UUID().uuidString,
        text: String,
        deadline: Date?,
        isDone: Bool = false,
        createdAt: Date = Date(),
        changedAt: Date? = nil,
        priority: Priority = .normal,
        color: Color = .white
    ) {
        self.id = id
        self.text = text
        self.deadline = deadline
        self.isDone = isDone
        self.createdAt = createdAt
        self.changedAt = changedAt
        self.priority = priority
        self.color = color
    }

}

