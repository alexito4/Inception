
import CoreFoundation

public struct Dream {
    public var levels: Int
    
    public init(levels: Int) {
        self.levels = levels
        
        
        dumpAtExit(self, fileNo: 1)
    }
}

// MARK: Package Dumping

private var dumpInfo: (dream: Dream, fileNo: Int32)? = nil
private func dumpAtExit(_ dream: Dream, fileNo: Int32) {
    func dump() {
        guard let dumpInfo = dumpInfo else { return }
        
        print("Levels \(dumpInfo.dream.levels)")
    }
    dumpInfo = (dream, fileNo)
    atexit(dump)
}