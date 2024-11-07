//
//  HomeView.swift
//  Healthcare
//
//  Created by Joseph Dung on 5/11/24.
//

import SwiftUI

struct HomeView:View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        VStack(spacing:15){
            Rectangle()
                .fill(Color.blue)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Spacer(minLength: 0)
            Text("Weight")
            Text("\(getWeight()) kg")
            let pickerCount = 6
            CustomSlider(pickerCount: pickerCount, offet: $offset,content: {
                HStack(spacing:0){
                    ForEach(1...pickerCount,id:\.self){ index in
                        Rectangle().fill(Color.gray)
                            .frame(width: 1,height: 30)
                            .frame(width: 20)
                        
                        ForEach(1...4,id:\.self){ subIndex in
                            Rectangle().fill(Color.gray)
                                .frame(width: 1,height: 15)
                                .frame(width: 20)
                        }
                    }
                    Rectangle().fill(Color.gray)
                        .frame(width: 1,height: 30)
                        .frame(width: 20)
                    
                    
                }
            })
            .frame(height: 50)
            .overlay(
                Rectangle()
                    .fill(Color.gray)
                    .frame(width:1, height:50)
                    .offset(x:1,y: -30))
            .padding()
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity )
        .background(
            Circle().fill(Color.green)
                .scaleEffect(1.5)
                .offset(y: -getRect().height / 2.4)
        )
        
        
    }
    
    
    func getWeight() -> String {
        let startWeight = 40
        let progress = offset / 20
        
        return "\(startWeight + (Int(progress) * 2))"
    }
}

func getRect() -> CGRect {
    return UIScreen.main.bounds
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
