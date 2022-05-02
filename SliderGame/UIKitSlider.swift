//
//  UIKitSlider.swift
//  SliderGame
//
//  Created by Alexander on 02.05.2022.
//

import SwiftUI

struct UIKitSlider: UIViewRepresentable {
    @Binding var value: Double
    let alpha: Int

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        //slider.thumbTintColor = initRed(with: alpha)

        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.thumbTintColor = initRed(with: alpha)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    private func initRed(with alpha: Int) -> UIColor {
        UIColor(red: 1, green: 0, blue: 0, alpha: Double(alpha) / 100)
    }
}

extension UIKitSlider {
    final class Coordinator: NSObject {
        @Binding var value: Double

        init(value: Binding<Double>) {
            self._value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct UIKitSlider_Previews: PreviewProvider {
    static var previews: some View {
        UIKitSlider(value: .constant(12), alpha: 50)
    }
}
