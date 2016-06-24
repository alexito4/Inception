
import DreamDescription

// You can run arbitrary Swift code!
let levels: Int = {
    
    return Int(arc4random_uniform(3))
    
//    if Process.arguments.contains("--deep") {
//        return 2
//    }
//
//    return 1
}()

// The definition of a Dream
var dream = Dream(
    levels: levels
)
