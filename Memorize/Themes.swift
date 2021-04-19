//
//  Themes.swift
//  Memorize
//
//  Created by kristaps.cikuts on 06/04/2021.
//

import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
    var noOfPairs: Int?
}

let themes: [Theme] = [
    Theme(
        name: "Halloween",
        emojis: ["👻","🎃","🕷","🔮","🧛🏼‍♀️","🦇","☠️","🦹‍♀️","🌘","👽","⚰️","🧟‍♂️"],
        color: .black),
    Theme(
        name: "Flags",
        emojis: ["🇱🇻","🇯🇵","🇱🇹","🇦🇺","🇬🇧","🇦🇹","🇺🇸","🇪🇪","🇫🇮","🇳🇴","🇲🇨","🇪🇸"],
        color: .red,
        noOfPairs: 6),
    Theme(
        name: "Animals",
        emojis: ["🐶","🐱","🐭","🐰","🐯","🦁","🦡","🦥","🐸","🐼","🐺","🦈"],
        color: .pink),
    Theme(
        name: "Places",
        emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"],
        color: .blue),
    Theme(
        name: "Sports",
        emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"],
        color: .green),
    Theme(
        name: "Foods",
        emojis: ["🍔","🍕","🍝","🍗","🍪","🍩","🌮","🥖","🍟","🥩","🍢","🍿"],
        color: .pink)
]
