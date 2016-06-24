#!/usr/bin/env swift -I /Users/alejandromartinez/Library/Developer/Xcode/DerivedData/Inception-eotatmudfqrhfnaqgpgfhxxsutlc/Build/Products/Debug -F /Users/alejandromartinez/Library/Developer/Xcode/DerivedData/Inception-eotatmudfqrhfnaqgpgfhxxsutlc/Build/Products/Debug -framework DreamDescription -target x86_64-apple-macosx10.11

import Foundation
import DreamDescription

let swift = "/Users/alejandromartinez/.swiftenv/shims/swift"
let libdir = "/Users/alejandromartinez/Library/Developer/Xcode/DerivedData/Inception-eotatmudfqrhfnaqgpgfhxxsutlc/Build/Products/Debug"
let manifestPath = "/Users/alejandromartinez/Dropbox/Projects/Inception/Dream.swift"
let tempPath = NSTemporaryDirectory() + "dream"

var cmd: [String] = []//["swift"]
cmd += ["--driver-mode=swift"]
cmd += ["-I", libdir]

cmd += ["-F", libdir]
cmd += ["-framework", "PackageDescription"]

#if os(OSX)
cmd += ["-target", "x86_64-apple-macosx10.11"]
#endif
cmd += [manifestPath]

// Give the temporary output file path
cmd += ["-output", tempPath]

// Passthrough other arguments
cmd += Process.arguments.suffix(from: 1)

// Dump
let task: NSTask = {
    $0.launchPath = swift
    $0.arguments = cmd
    return $0
}(NSTask())

task.launch()
task.waitUntilExit()

// Read the configuration
let data = NSData(contentsOfFile: tempPath)!
let json = try! NSJSONSerialization.jsonObject(with: data, options: .allowFragments)
//print(json)

let dream = try! Dream.fromJSON(json: json)

// Do something with the created object
print("Dream successfully created!")
print(dream)

try! NSFileManager.default().removeItem(atPath: tempPath)