//
//  NSArray+Extension.swift
//  Maya
//
//  Created by Trong_iOS on 8/29/16.
//  Copyright © 2016 Autonomous. All rights reserved.
//

extension Array where Element: Equatable {
    mutating func remove(_ object: Element) {
        if let index = index(where: { $0 == object }) {
            self.remove(at: index)
        }
    }
}

extension Array where Element: AnyObject {
    mutating func remove(_ object: Element) {
        if let index = index(where: { $0 === object }) {
            self.remove(at: index)
        }
    }
}
