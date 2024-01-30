import SwiftUI

struct UpdateTennantView: View {
    @State var amountAdded: String = ""
    
    var body: some View {
        VStack {
            UpdateTennantTopCardView()
            
            CircularProgressView(progress: 0.8)
                .frame(width: 200, height: 200)
            
            // Add done button and tap to dismiss
            TextField("Amount paid", text: $amountAdded)
                .frame(height: 50)
                .buttonHorizontalPadding()
                .padding(.top)
                .keyboardType(.numberPad)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Paid in full")
                    .padding()
            }
            .buttonHorizontalPadding()
            
            Button {
                
            } label: {
                Text("Add payment")
                    .padding()
            }
            .buttonHorizontalPadding()
            .disabled(amountAdded == "")
        }
        .background {
            Color("PastelGrey")
                .ignoresSafeArea()
        }
    }
}
