//
//  LetterCounterApp.swift
//  LetterCounter
//
//  Created by 松本幸太郎 on 2023/07/28.
//

import SwiftUI

@main
struct LetterCounterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var counter: Int = 0

    var body: some Scene {
        MenuBarExtra {
            Text("Characters: \(counter)")
            Text("Words: \(counter)")
        } label: {
            Text("\(counter)")
                .onReceive(NotificationCenter.default.publisher(for: .NSPasteboardDidChange)){ notification in
                    guard let pb = notification.object as? NSPasteboard else { return }
                    guard let items = pb.pasteboardItems else { return }
                    guard let item = items.first?.string(forType: .string) else { return } // you should handle multiple types
                    counter = item.count
                }
        }

    }
    
}
