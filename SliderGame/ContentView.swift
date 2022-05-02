//
//  ContentView.swift
//  SliderGame
//
//  Created by Alexander on 01.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = Double.random(in: 0...100)
    @State private var score = 100
    @State private var isAlertPresented = false

    var body: some View {
        VStack(spacing: 32) {
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
                .frame(height: 100)
            HStack {
                Text("0")
                UIKitSlider(value: $currentValue, alpha: score)
                    .onAppear {
                        score = computeScore()
                    }
                    .onChange(of: currentValue) { _ in
                        score = computeScore()
                }
                Text("100")
            }

            Button("Проверь меня!") {
                isAlertPresented = true
            }
            .alert( "Your score", isPresented: $isAlertPresented, actions: {}) {
                Text("\(score)")
            }

            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
            }
            .onChange(of: targetValue) { _ in
                score = computeScore()
            }
        }
        .padding()
    }

    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("IPhone 13")
    }
}
