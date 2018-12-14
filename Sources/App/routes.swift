import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("hello", "vapor") { req in
        return "Hello Vapor"
    }
    
    
    router.get("date", Int.parameter) { req -> String in
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
//    router.get("date") { req in
//
//    }
    
//    router.get("date") { req in
//        var date = DateTime.Now
//        return String(date)
//    }
    
//    router.post(InfoData.self, at: "info") { req, data -> String in
//        return "Hello \(data.name)"
//    }

    router.post(InfoData.self, at: "info") { req, data -> InfoResponse in
        return InfoResponse(request: data)
    }
    
  
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    
    let request: InfoData
}
