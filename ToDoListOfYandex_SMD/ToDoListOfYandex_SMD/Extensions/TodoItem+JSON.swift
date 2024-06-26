//
//  TodoItem+JSON.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 23.06.2024.
//

import Foundation

extension TodoItem{
    var json: Any {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        
        var jsonDict = [String: Any]()
        jsonDict["id"] = id
        jsonDict["text"] = text
        jsonDict["isDone"] = isDone
        jsonDict["createdAt"] = formatter.string(from: createdAt)
        if let changedAt = changedAt{
            jsonDict["changedAt"] = formatter.string(from: changedAt)
        }
        if let deadline = deadline{
            jsonDict["deadline"] = formatter.string(from: deadline)
        }
        if priority != .normal{
            jsonDict["priority"] = priority.rawValue
        }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options:  []), let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {return [:]}
        
        return jsonResult
    }
  
    static func parse(json: Any) -> TodoItem? {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []),
              let todoItem = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
              let id = todoItem["id"] as? String,
              let text = todoItem["text"] as? String,
              let createdAtString = todoItem["createdAt"] as? String,
              let createdAt = formatter.date(from: createdAtString ) else {
            return nil
        }
        let priorityString = todoItem["priority"] as? String ?? Priority.normal.rawValue
        guard let priority = Priority(rawValue: priorityString) else {return nil}
        
        let deadline: Date?
        
        if let deadlineString = todoItem["deadline"] as? String{
            deadline = formatter.date(from: deadlineString)
        }else {
            deadline = nil
        }
        let isDone = todoItem["isDone"] as? Bool ?? false
        
        let changedAt: Date?
        if let changedAtString = todoItem["changedAt"] as? String{
            changedAt = formatter.date(from: changedAtString)
        }else{
            changedAt = nil
        }
        return TodoItem(id: id, text: text, deadline: deadline, isDone: isDone, createdAt: createdAt, changedAt: changedAt, priority: priority)
        
    }
}
