
import Foundation



let path = "/Users/alejandromartinez/Dropbox/Projects/Inception/config.swift"

let config = try! NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
print(config)
