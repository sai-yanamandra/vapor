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
    
    
    router.get("date") { req -> String in
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    router.get("counter",Int.parameter) { req -> CountJSON in
        let countVal = try req.parameters.next(Int.self)
        return (CountJSON(count:countVal))
    }

}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}


struct CountJSON: Content {
    let count: Int
}

struct UserInfoData: Codable {
    let name: String
    let age: Int
}
