
import SwiftUI

struct ChartView: View {
    
    let fuel: Int
    let service: Int
    let tax: Int
    let other: Int
    
    var maximum: Int {
        max(fuel, service, tax, other, 10)
    }
    
    var range: Int {
        Int(Double(maximum) / 4)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    divider(value: "$\(maximum)")
                    Spacer()
                    divider(value: "$\(maximum - range)")
                    Spacer()
                    divider(value: "$\(maximum - 2 * range)")
                    Spacer()
                    divider(value: "$\(maximum - 3 * range)")
                    Spacer()
                    divider(value: "$0")
                }
                .overlay(alignment: .bottom) {
                    HStack(alignment: .bottom, spacing: 30.flexible()) {
                        chartRectangle(height: (geo.size.height - (UIDevice.isSmallIphone ? 0 : 15)) * calculatePart(fuel, maximum: maximum), color: .appRed)
                        
                        chartRectangle(height: (geo.size.height - (UIDevice.isSmallIphone ? 0 : 15)) * calculatePart(service, maximum: maximum), color: Color(hex: 0x2E2E8A))
                        
                        chartRectangle(height: (geo.size.height - (UIDevice.isSmallIphone ? 0 : 15)) * calculatePart(tax, maximum: maximum), color: Color(hex: 0x1A862A))
                        
                        chartRectangle(height: (geo.size.height - (UIDevice.isSmallIphone ? 0 : 15)) * calculatePart(other, maximum: maximum), color: Color(hex: 0xBC6107))
                    }
                    .padding(.leading, 30.flexible())
                }
            }
            .padding(.top, 4.flexible())
            
            legend
                .padding(.vertical, 16.flexible())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16.flexible())
        .padding(.horizontal, 20.flexible())
        .frame(height: 326.flexible())
        .background(Color.appGray)
        .cornerRadius(16)
    }
    
    private func calculatePart(_ value: Int, maximum: Int) -> Double {
        return min(max(Double(value) / Double(maximum), 0), 1)
    }
}

extension ChartView {
    private var legend: some View {
        HStack() {
            legendItem("Fuel", color: .appRed)
                .frame(maxWidth: .infinity)
            legendItem("Service", color: Color(hex: 0x2E2E8A))
                .frame(maxWidth: .infinity)
            legendItem("Tax", color: Color(hex: 0x1A862A))
                .frame(maxWidth: .infinity)
            legendItem("Other", color: Color(hex: 0xBC6107))
                .frame(maxWidth: .infinity)
        }
    }
    
    private func divider(value: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(value)
                .font(.inter(11.flexible(), weight: .medium))
                .foregroundColor(.white)
                .opacity(0.52)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.flexible())
                .foregroundStyle(Color.white.opacity(0.2))
        }
    }
    
    private func legendItem(_ title: String, color: Color) -> some View {
        HStack(spacing: 4.flexible()) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 16.flexible(), height: 16.flexible())
              .background(color)
              .cornerRadius(4.flexible())
            
            Text(title)
                .font(.inter(14.flexible(), weight: .medium))
                .foregroundColor(.white)
        }
    }
    
    private func chartRectangle(height: CGFloat, color: Color) -> some View {
        Rectangle()
            .frame(maxHeight: max(height, 5))
            .frame(width: 24.flexible())
            .foregroundStyle(color)
            .cornerRadius(8.flexible(), corners: [.topLeft, .topRight])
    }
}

#Preview {
    ChartView(fuel: 10000, service: 40000, tax: 2000, other: 42500)
}
