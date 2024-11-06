import SwiftUI

struct RoundedBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(.white)
            .cornerRadius(12.0)
            .shadow(color: .gray, radius: 1)
            .overlay( RoundedRectangle(cornerRadius: 12) .stroke(Color.gray, lineWidth: 0.5) )
    }
}

struct PasswordFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration.padding(12).background(Color.white).cornerRadius(12.0).shadow(
            color: .gray, radius: 1)
    }
}
