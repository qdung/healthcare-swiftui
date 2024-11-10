import SwiftUI

struct SelectWeightView: View {
    @State private var weight: CGFloat = 0
    @State private var weightType:Int = 1
    let weightTypeList = ["Kg","Lbs","Gram"]
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(rgb: 0xFC6D22)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
    }
    
    var body: some View {
        VStack {
            Text("Select Weight")
            Picker(selection: $weightType, label: Text("")) {
                ForEach(weightTypeList.indices, id:\.self) { index in
                    Text("\(weightTypeList[index])").tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            CircularSlider(selection: $weight, from: 30, to: 150, label: Binding(
                get: { weightTypeList[weightType] },
                set: { _ in }
            ),type: .wholeNumber)
            Spacer()
            Button(action: {
                print("Helelo")
            }, label: {
                Text("Next")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(Color.green)
                    .cornerRadius(8)
            })
            
            .padding()
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .top)
    }
}

#Preview{
    SelectWeightView()
}

