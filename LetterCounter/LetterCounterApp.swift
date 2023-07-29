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
    @State private var menuBarIcon = Counter.Kind.words
    
    var body: some Scene {
        MenuBarExtra {
            Button("\(counter.characters) characters") {
                menuBarIcon = .characters
            }
            Button("\(counter.words) words") {
                menuBarIcon = .words
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        } label: {
            
            let icon: String =  switch menuBarIcon {
            case .words: "\(counter.words)W"
            case .characters: "\(counter.characters)C"
            }
            
            Text("\(icon)")
                .onReceive(NotificationCenter.default.publisher(for: .NSPasteboardDidChange)){ notification in
                    guard let pb = notification.object as? NSPasteboard else { return }
                    guard let items = pb.pasteboardItems else { return }
                    guard let item = items.first?.string(forType: .string) else { return } // you should handle multiple types
                    counter.characters = item.count
                    
                    let tokenizer = NLTokenizer(unit: .word)
                    tokenizer.string = item
                    let range = item.startIndex..<item.endIndex
                    let tokenArray = tokenizer.tokens(for: range)
                    counter.words = tokenArray.count
                }
        }
        
    }
}
