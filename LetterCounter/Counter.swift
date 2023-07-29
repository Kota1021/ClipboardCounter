//
//  Counter.swift
//  LetterCounter
//
//  Created by 松本幸太郎 on 2023/07/29.
//

import SwiftUI

class Counter: ObservableObject {
    @Published var characters: Int = 0
    @Published var words: Int = 0
    
    enum Kind {
        case words, characters
    }
}
