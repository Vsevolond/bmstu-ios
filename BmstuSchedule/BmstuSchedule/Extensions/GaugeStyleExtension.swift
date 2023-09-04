import SwiftUI

struct LinearTextInsideGaugeStyle: GaugeStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 25, maxHeight: 25, alignment: .leading)
                GeometryReader { g in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .frame(width: configuration.value * g.size.width, height: 25, alignment: .leading)
                }
            }
            configuration.label
                .foregroundColor(.white)
                .bold()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
