import SwiftUI

struct OnboardingSubView: View {
    @Binding var input: String
    @FocusState var isInputActive: Bool
    
    var title: String
    var image: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Image(image)
                .resizable()
                .frame(width: 250, height: 250)
            
            
            if input == "" {
                Text("Title subtitle text need to figure out what to put here maybe explaining whats going to happen")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                TextField(" Number of properties", text: $input)
                    .numberTextField()
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
                    .padding(.bottom)
            }
        }
        .backgroundColour()
    }
}

#Preview {
    OnboardingSubView(input: .constant(""), title: "", image: "")
}
