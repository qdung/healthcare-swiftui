//
//  BiographyView.swift
//  Healthcare
//
//  Created by Joseph Dung on 8/11/24.
//

import SwiftUI

struct BiographyView: View {
    
    let weights = Array(30...150)
    let weightTypeList = ["Kg","Lbs","Gram"]
    
    @State private var selectedWeight: Int = 70
    @State private var weightType: Int? = 0
    
    var body: some View {
        VStack {
            Text("Select Weight")
                .font(.headline)
                .padding()
            
            RadioGroupButton(selectedOption: $weightType, options: weightTypeList)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(weights, id: \.self) { weight in
                        VStack {
                            Text("\(weight)")
                                .font(.title2)
                                .fontWeight(weight == selectedWeight ? .bold : .regular)
                                .foregroundColor(weight == selectedWeight ? .blue : .gray)
                            
                            Text("kg")
                                .font(.caption)
                                .foregroundColor(weight == selectedWeight ? .blue : .gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(weight == selectedWeight ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                        )
                        .onTapGesture {
                            selectedWeight = weight
                        }
                    }
                }
                .padding()
            }
            
            Text("Selected Weight: \(selectedWeight) kg")
                .font(.subheadline)
                .padding()
        }
        .padding()
    }
}

struct BiographyView_Previews: PreviewProvider {
    static var previews: some View {
        BiographyView()
    }
}
