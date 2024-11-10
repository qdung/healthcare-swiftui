import SwiftUI
import UIKit

struct RulerSlider: UIViewRepresentable {
    @Binding var currentValue: CGFloat
    var minValue: CGFloat
    var maxValue: CGFloat
    var stepValue: CGFloat
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: RulerSlider
        
        init(parent: RulerSlider) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset.y
            parent.currentValue = parent.minValue + (offset / scrollView.contentSize.height) * (parent.maxValue - parent.minValue)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        
        let rulerView = UIView()
        scrollView.addSubview(rulerView)
        
        rulerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rulerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rulerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rulerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rulerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rulerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let totalSteps = Int((maxValue - minValue) / stepValue)
        for i in 0...totalSteps {
            let line = UIView()
            line.backgroundColor = .black
            rulerView.addSubview(line)
            line.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                line.leadingAnchor.constraint(equalTo: rulerView.leadingAnchor, constant: 10),
                line.trailingAnchor.constraint(equalTo: rulerView.trailingAnchor, constant: -10),
                line.heightAnchor.constraint(equalToConstant: i % 10 == 0 ? 20 : 10),
                line.topAnchor.constraint(equalTo: rulerView.topAnchor, constant: CGFloat(i) * 20)
            ])
        }
        
        rulerView.heightAnchor.constraint(equalToConstant: CGFloat(totalSteps) * 20).isActive = true
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let offset = (currentValue - minValue) / (maxValue - minValue) * uiView.contentSize.height
        uiView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
    }
}
