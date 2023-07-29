//
//  SettingView.swift
//  LetterCounter
//
//  Created by 松本幸太郎 on 2023/07/29.
//

import SwiftUI

struct SettingView: View {
    @State var counterOnManuBar: CounterKind = .words
    var body: some View {
        Picker("Menu bar Counter", selection: $counterOnManuBar) {
            Text("words").tag(CounterKind.words)
            Text("characters").tag(CounterKind.characters)
        }.pickerStyle(.radioGroup)
    }
    enum CounterKind {
        case words, characters
    }
}

//#Preview {
//    SettingView()
//}
