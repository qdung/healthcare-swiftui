//
//  CircularSlider.swift
//  Healthcare
//
//  Created by Joseph Dung on 8/11/24.
//

import SwiftUI

struct CircularSlider: View {
    enum CircularPickerViewType { case wholeNumber, tenths }
    @State private var radius: CGFloat = .zero
    @Binding var selection: CGFloat
    @Binding var label: String
    let from: Int
    let to: Int
    let type: CircularPickerViewType
    
    init(selection: Binding<CGFloat>, from: Int, to: Int,label:Binding<String>, type: CircularPickerViewType = .wholeNumber) {
        self._selection = selection
        self.from = from
        self.to = type == .wholeNumber ? to: to * 10
        self.type = type
        self._label = label
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(.horizontal){
                    HStack(spacing:0){
                        Spacer(minLength: radius)
                        HStack(spacing:10){
                            ForEach(from...to, id: \.self) { number in
                                Rectangle()
                                    .frame(width: 2, height: number % 10 == 0 ? 60 : number % 5 == 0 ? 40 : 20)
                                    .foregroundStyle(number % 5 == 0 ? .primary : .secondary)
                                    .visualEffect { content, geometry in
                                        content
                                            .rotationEffect(.degrees(-90.0 * (1 - getXPosPercentage(xPos: geometry.frame(in: .global).minX))))
                                            .offset(getOffset(id: type == .wholeNumber ? CGFloat(number) : CGFloat(number / 10), xPos: geometry.frame(in: .global).minX))
                                    }
                            }
                        }
                        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .offset(y: radius / 2)
                        .scrollTargetLayout()
                        Spacer(minLength: radius - 2)
                    }
                }
                .frame(maxHeight: radius)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
                .mask {
                    Circle()
                        .frame(width: radius * 2, height: radius * 2)
                        .offset(y: radius / 2)
                }
                VStack {
                    Rectangle()
                        .foregroundStyle(.green)
                        .frame(width: 2, height: 50)
                        .frame(width: 80)
                        .overlay {                            
                            Text(String(format: type == .wholeNumber ? "%.0f" : "%.1f", selection) + " " + label)
                                .font(.system(size: 28.0)).foregroundStyle(.green)
                                .lineLimit(1)
                                .scaledToFit()
                                .minimumScaleFactor(0.1)
                                .offset(y: 60)
                        }
                        .offset(x:1, y: -radius / 2 + 25)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .onAppear (){
                    radius = min(geo.size.width, geo.size.height)/2
                }
            }
        }
    }
    
    private func getXPosPercentage(xPos: CGFloat) -> CGFloat {
        let circularArcLength = CGFloat.pi * radius / 2
        return (circularArcLength - (radius - xPos)) / circularArcLength
    }
    
    private func getOffset(id: CGFloat, xPos: CGFloat) -> CGSize {
        let xPosPercentage = getXPosPercentage(xPos: xPos)
        if xPosPercentage > 2 || xPosPercentage < 0 { return .zero}
        let angle = CGFloat.pi / 2 * xPosPercentage
        
        if xPosPercentage > 0.97 && xPosPercentage < 1.3 { DispatchQueue.main.async {
            selection = id }}
        return CGSize(width: radius - (radius * cos(angle)) - xPos, height: -radius * sin(angle) )
    }
}

#Preview {
    CircularSlider(selection: .constant(0), from: 0, to: 100, label: .constant("Kg"))
}
