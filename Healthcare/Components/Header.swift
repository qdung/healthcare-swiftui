import SwiftUI

struct Header: View {
    var title: String
    var showBackButton: Bool
    var actionButtonTitle: String
    var actionButtonAction: () -> Void
    var backButtonAction: (() -> Void)?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            HStack {
                if showBackButton {
                    Button(action: {
                        if let backButtonAction = backButtonAction {
                            backButtonAction()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                } else {
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    actionButtonAction()
                }) {
                    Text(actionButtonTitle)
                        .foregroundColor(.blue)
                    
                }
            }
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}
