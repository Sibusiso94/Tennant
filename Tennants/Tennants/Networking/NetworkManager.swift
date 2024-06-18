import Foundation

protocol NetworkManager {
    func setUpURL(bankType: String, reference: String, pdfURL: String) -> String
    func fetchUserData(apiURL: String, completion: @escaping ([TenantData]) -> ())
}

final class NetworkManagerConcreation: ObservableObject, NetworkManager {
    @Published var isLoading = false
    
    func setUpURL(bankType: String = "Standard",
                  reference: String = "STANSAL",
                  pdfURL: String = "/Users/sibusisom@glucode.com/Documents/Prac/PDFReader/BankStatements/StandardBank.pdf") -> String {
        let apiURL = "http://192.168.1.43:5000/api/fetchingAndReturning?bankType=\(bankType)&referenceName=\(reference)&pdfURL=\(pdfURL)"
        return apiURL
    }
    
    func fetchUserData(apiURL: String, completion: @escaping ([TenantData]) -> ()) {
        isLoading = true
        if let url = URL(string: apiURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        // Handle error
                        print("Error occurred: \(error)")
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                        // Handle invalid response
                        print("Invalid response")
                        return
                    }
                    
                    guard let data = data else {
                        // Handle missing data
                        print("No data received")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let tenantData = try decoder.decode([TenantData].self, from: data)
                        self?.isLoading = false
                        completion(tenantData)
                    } catch {
                        // Handle decoding error
                        self?.isLoading = false
                        print("Error parsing data: \(error)")
                    }
                }
            }
            .resume()
        } else {
            // Handle invalid URL
            print("Invalid URL")
        }
    }
}
