import SwiftUI

struct RadioGroupButton: View {
    @Binding var selectedOption: Int?
    @Namespace private var animationNamespace
    let options: [String]
    
    var body: some View {
        VStack {
            Text("Select an Option")
                .font(.headline)
                .padding()
            
            HStack {
                ForEach(options.indices, id: \.self) { index in
                    RadioButton(option: index, label: options[index], selectedOption: $selectedOption, animationNamespace: animationNamespace)
                }
            }
            .padding()
            .background(
                ZStack {
                    if let selectedOption = selectedOption {
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.green)
                                .matchedGeometryEffect(id: selectedOption, in: animationNamespace)
                                .frame(width: geometry.size.width / CGFloat(options.count) - 10, height: geometry.size.height - 25)
                                .offset(x: CGFloat(selectedOption) * (geometry.size.width / CGFloat(options.count)) - 10,y : -5)
                                .padding()
                        }
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding()
    }
}

struct RadioButton: View {
    let option: Int
    let label: String
    @Binding var selectedOption: Int?
    var animationNamespace: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedOption = option
            }
        }) {
            Text(label)
                .fontWeight(selectedOption == option ? .bold : .regular)
                .foregroundColor(selectedOption == option ? .white : .blue)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                )
                .frame(maxWidth: .infinity,alignment: .center)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.vertical,10)
    }
}

struct RadioGroupButtonView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selected:Int? = 0
        RadioGroupButton(selectedOption: $selected, options: ["Kg", "Pound", "Gram"])
    }
}
