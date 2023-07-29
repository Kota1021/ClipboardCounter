//
//  LetterCounterApp.swift
//  LetterCounter
//
//  Created by 松本幸太郎 on 2023/07/28.
//

import SwiftUI
import Foundation

@main
struct LetterCounterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var counter = Counter()

    var body: some Scene {
        MenuBarExtra {
            Text("Characters: \(counter.characters)")
            Text("Words: \(counter.words)")
        } label: {
            Text("\(counter.characters)")
                .onReceive(NotificationCenter.default.publisher(for: .NSPasteboardDidChange)){ notification in
                    guard let pb = notification.object as? NSPasteboard else { return }
                    guard let items = pb.pasteboardItems else { return }
                    guard let item = items.first?.string(forType: .string) else { return } // you should handle multiple types
                    counter.characters = item.count
                    counter.words = NSSpellChecker.shared.countWords(in: item, language: "En")
                }
        }

    }
    
}
