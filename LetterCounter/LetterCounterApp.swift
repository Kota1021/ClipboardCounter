//
//  LetterCounterApp.swift
//  LetterCounter
//
//  Created by 松本幸太郎 on 2023/07/28.
//

import SwiftUI
import NaturalLanguage

@main
struct LetterCounterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var counter = Counter()

    var body: some Scene {
        MenuBarExtra {
            Text("\(counter.characters) characters")
            Text("\(counter.words) words")
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        } label: {
            Text("\(counter.characters)")
                .onReceive(NotificationCenter.default.publisher(for: .NSPasteboardDidChange)){ notification in
                    guard let pb = notification.object as? NSPasteboard else { return }
                    guard let items = pb.pasteboardItems else { return }
                    guard let item = items.first?.string(forType: .string) else { return } // you should handle multiple types
                    counter.characters = item.count

                    let tokenizer = NLTokenizer(unit: .word)
                    tokenizer.string = item
                    let range = item.startIndex..<item.endIndex
                    let tokenArray = tokenizer.tokens(for: range)
                    if let text = tokenizer.string {
                        counter.words = tokenArray.count
                    } else {
                        counter.words = 0
                    }
                }
        }

    }
}
