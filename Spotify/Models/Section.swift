//
//  Settings.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 25/02/2025.
//

import Foundation


struct Section {
    let title: String
    let options: [Options]
}

struct Options {
    let title: String
    let handler : () -> Void
}
