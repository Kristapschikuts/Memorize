//
//  Array+ONly.swift
//  Memorize
//
//  Created by kristaps.cikuts on 06/04/2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
