//
//  Date.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 03.07.2024.
//

import Foundation



func formatDateShort(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM YYYY"
    return formatter.string(from: date)
}

func formatDateLong(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM YYYY"
    return formatter.string(from: date)
}




//extension Date{
//    func formatDate(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d MMMM"
//        return formatter.string(from: date)
//    }
//
//}
