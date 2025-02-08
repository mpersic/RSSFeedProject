//
//  CustomTextField.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @FocusState var focusedField: FocusedField?
    let field: FocusedField
    let placeholder: String
    let onSubmit: () -> Void
    let isPassword: Bool
//    let font: Font
    let lineWidth: CGFloat
    let keyboardType: UIKeyboardType
    let leadingIcon: String
    let leadingIconSize: CGFloat = 24
    
    init(text: Binding<String>,
         focusedField: FocusState<FocusedField?>,
         field: FocusedField,
         placeholder: String,
         isPassword: Bool = false,
         onSubmit: @escaping () -> Void,
//         font: Font = .custom(Fonts.PoppinsMedium, size: Dimensions.fontSizeSmallForDevice()),
         lineWidth: CGFloat = 2,
         keyboardType: UIKeyboardType = .default,
         leadingIcon: String = "") {
        _text = text
        _focusedField = focusedField
        self.field = field
        self.placeholder = placeholder
        self.onSubmit = onSubmit
        self.isPassword = isPassword
//        self.font = font
        self.lineWidth = lineWidth
        self.keyboardType = keyboardType
        self.leadingIcon = leadingIcon
    }

    var body: some View {
        let frameBackground = RoundedRectangle(cornerRadius: 12).stroke(.black, lineWidth: lineWidth)
        Section {
            HStack {
                if !leadingIcon.isEmpty{
                    Image(leadingIcon)
                      .resizable()
                      .frame(width: leadingIconSize, height: leadingIconSize)
                }
                if isPassword {
                    SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                    }
                } else {
                    TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                    }
                }
            }
        }
//        .font(font)
        .padding()
        .background(frameBackground)
        .keyboardType(keyboardType)
        .focused($focusedField, equals: field)
        .onSubmit {
            onSubmit()
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldPreviewContainer()
    }
}

struct CustomTextFieldPreviewContainer: View {
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack(spacing: 20) {
            CustomTextField(
                text: $email,
                focusedField: _focusedField,
                field: .email,
                placeholder: "Email",
                onSubmit: {
                    print("Submitted Email")
                    focusedField = .password
                }
            )
            CustomTextField(
                text: $password,
                focusedField: _focusedField,
                field: .password,
                placeholder: "Password",
                isPassword: true,
                onSubmit: {
                    print("Submitted Password")
                }
            )
        }
        .padding()
        .frame(height: UIScreen.height)
        .background(.gray)
    }
}

