//
//  Date+Helpers.swift
//  Trackr
//
//  Created by Danmark Arqueza on 1/25/21.
//

import Foundation

extension Date {

    /// Property that contains the milliseconds equivalent of Date.
    ///
    var millisecondsSince1970: Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }

    /// Initializer that takes a Double milliseconds.
    ///
    /// - parameters:
    ///     - milliseconds: the double timestamp to be converted to date
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

}
