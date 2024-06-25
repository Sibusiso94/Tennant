import SwiftUI
import UniformTypeIdentifiers
import MyLibrary

struct PDFReaderView: View {
    @StateObject var fileManager = FPDDataManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                VStack {
                    DocumentSelectionView(image: Image("\(fileManager.selectedBankType.lowercased())"),
                                          imageWidth: fileManager.selectedBankType == "Capitec" ? 300 : 200,
                                          bankTypes: fileManager.bankTypes,
                                          selectedBankType: $fileManager.selectedBankType) {
                        fileManager.showPDFImporter.toggle()
                    }
                }
                .sheet(isPresented: $fileManager.showPDFImporter) {
                    DocumentPicker()
                }
            }
//            .navigationTitle("Select a PDF")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let _ = fileManager.results {
                        Button {
                            fileManager.shouldShowResultView.toggle()
                        } label: {
                            Text("History")
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $fileManager.shouldShowResultView) {
                ZStack {
                    Color("PastelGrey")
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack {
                            if let results = fileManager.results {
                                ForEach(results, id: \.id) { result in
                                    UserDetailsCard(reference: result.reference,
                                                    amount: result.amount,
                                                    date: result.date,
                                                    isCompletePayment: fileManager.isPaymentComplete(amount: result.amount))
                                }
                            }
                        }
                    }
                }
                .navigationTitle("History")
            }
            .overlay {
                if fileManager.isLoading {
                    ProgressView()
                        .scaleEffect(5)
                        .padding(.bottom)
                }
            }
        }
    }
}
