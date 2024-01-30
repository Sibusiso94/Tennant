import SwiftUI

struct UpdateTennantTopCardView: View {
    var body: some View {
        HStack {
            Image(systemName: "9.square")
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
                .padding()
            
            Spacer()
                .frame(width: 16)
            VStack(alignment: .leading) {
                Text("Name Surname")
                HStack {
                    Text("Balance:")
                    Text("-260")
                }
                
                HStack {
                    Text("Amount Due:")
                    Text("230")
                }
            }
            
            Spacer()
        }
        .background {
            Color.white
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding()
        .foregroundStyle(Color.black)
    }
}

#Preview {
    UpdateTennantTopCardView()
}
