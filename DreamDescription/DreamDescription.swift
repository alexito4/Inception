
import CoreFoundation

extension Optional {
    
    func unwrap() throws -> Wrapped {
        switch self {
        case .none:
            throw NSError()
        case .some(let w):
            return w
        }
    }
    
}

public struct Dream {
    public var levels: Int
    
    public init(levels: Int) {
        self.levels = levels
        
        if let index = Process.arguments.index(of: "-output")?.advanced(by: 1) where index < Process.arguments.count {
            let tempPath = Process.arguments[index]
            dumpAtExit(self, atPath: tempPath)
        }
    }
}

public extension Dream {
    
    public static func fromJSON(json: AnyObject) throws -> Dream {
        guard let dic = json as? [String: AnyObject] else {
            throw NSError()
        }
        
        guard let levels = dic["levels"] as? Int else {
            throw NSError()
        }
        
        return Dream(levels: levels)
    }
    
    public func toJSON() throws -> String {
        let json = [
                       "levels": self.levels
        ] as AnyObject
        
        let jsonData = try NSJSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try String(data: jsonData, encoding: NSUTF8StringEncoding).unwrap()
    }
    
}

// MARK: Package Dumping

private var dumpInfo: (dream: Dream, path: String)? = nil
private func dumpAtExit(_ dream: Dream, atPath path: String) {
    func dump() {
        guard let dumpInfo = dumpInfo else { print("Can't dump: \(DreamDescription.dumpInfo)"); return }
        
        let jsonString = try! dumpInfo.dream.toJSON()
        try! jsonString.write(toFile: dumpInfo.path, atomically: true, encoding: NSUTF8StringEncoding)
    }
    dumpInfo = (dream, path)
    atexit(dump)
}