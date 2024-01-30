import SwiftUI

struct UpdateTennantTopCardView: View {
    var tennant: Tennant
    
    var body: some View {
        HStack {
            Image(systemName: "\(tennant.flatNumber).square")
                .resizable()
                .frame(width: 100, height: 100, alignment: .leading)
                .padding()
            
            Spacer()
                .frame(width: 16)
            VStack(alignment: .leading) {
                Text("\(tennant.name) \(tennant.surname)")
                HStack {
                    Text("Balance:")
                    Text("\(tennant.balance)")
                }
                
                HStack {
                    Text("Amount Due:")
                    Text("\(tennant.amountDue)")
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
    UpdateTennantTopCardView(tennant: Tennant())
}
