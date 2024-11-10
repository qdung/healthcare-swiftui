import SwiftUI

struct SelectHeightView: View {
    @State private var selectedHeight: CGFloat = 150
    @State private var currentOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Select Height")
                .font(.headline)
            HStack {
                GeometryReader { geo in
                    ZStack {
                        CustomScrollView(currentOffset: $currentOffset) {
                            VStack(spacing: 0) {
                                let from = 100
                                let to = 200
                                ForEach(from...to, id: \.self) { number in
                                    HStack(spacing: 20) {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(width: number % 10 == 0 ? 60 : number % 5 == 0 ? 40 : 20, height: 2)
                                        Spacer()
                                        Text("\(number) cm")
                                            .font(.caption)
                                            .foregroundColor(number % 10 == 0 ? .black : .gray)
                                            .fontWeight(number % 10 == 0  ? .bold : .regular)
                                    }
                                    .padding(.vertical, 5)
                                    .offset(y: -80 + currentOffset)
                                }
                                
                            }
                            .frame(height: 3200) // Ensure content height is sufficient
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 150, height: 2)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        
                        Text("\(getHeight(currentOffset)) cm")
                            .font(.title)
                            .foregroundColor(.red)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2 - 20)
                    }
                }
                .padding()
            }
            .padding(.horizontal)
            Spacer()
            Button(action: {}, label: {
                Text("Next")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.horizontal)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private func isCenter(number: Int, geo: GeometryProxy) -> Bool {
        let centerY = geo.size.height / 2
        let offset = CGFloat(number - 100) * 20
        return abs(centerY - offset) < 10
    }
    
    private func getHeight(_ offset: CGFloat) -> Int {
        let minHeight: CGFloat = 100
        let maxHeight: CGFloat = 200
        let maxOffset: CGFloat = 2433 // Adjust this value based on your content size
        let height = minHeight + (maxHeight - minHeight) * (offset / maxOffset)
        return Int(height)
    }
}

struct CustomScrollView<Content: View>: UIViewRepresentable {
    @Binding var currentOffset: CGFloat
    let content: Content
    
    init(currentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self._currentOffset = currentOffset
        self.content = content()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsVerticalScrollIndicator = false
        
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Update the scroll view content offset if needed
        if currentOffset > 2433 {
            uiView.setContentOffset(CGPoint(x: 0, y: 2433), animated: true)
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CustomScrollView
        
        init(_ parent: CustomScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.currentOffset = scrollView.contentOffset.y
        }
    }
}

struct SelectHeightView_Previews: PreviewProvider {
    static var previews: some View {
        SelectHeightView()
    }
}
