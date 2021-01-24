//
//  Console.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation
//import Crashlytics

enum LogLevel: String {
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

class Console {
    static private func log(logLevel: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        var emoji = ""
        let filePath = (file as NSString).lastPathComponent
        let messageToPrint = " [\(logLevel.rawValue)/\(filePath)/\(function):\(line)> \(message)"

        switch logLevel {
        case .info:
            emoji = "✏️"
            print(emoji + messageToPrint)
        case .warning:
            emoji = "⚠️"
            print(emoji + messageToPrint)
        case .error:
            emoji = "⛔️"
            print(emoji + messageToPrint)
        }
    }

    static func logInfo(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        Console.log(logLevel: .info, message: message, file: file, function: function, line: line)
    }

    static func logWarning(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        Console.log(logLevel: .warning, message: message, file: file, function: function, line: line)
    }

    static func logError(error: Error, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        //Crashlytics.sharedInstance().recordError(error)
        Console.log(logLevel: .error, message: message, file: file, function: function, line: line)
    }
}
