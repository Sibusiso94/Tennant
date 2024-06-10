import Foundation

class NetworkManager {
    func setUpURL(bankType: String = "Standard",
                  reference: String = "STANSAL",
                  pdfURL: String) -> String {
        let apiURL = "http://192.168.1.43:5000/api/fetchingAndReturning?bankType=\(bankType)&referenceName=\(reference)&pdfURL=\(pdfURL)"
        return apiURL
    }
    
    func fetchUserData() {
        let pdfUrl = "/Users/sibusisom@glucode.com/Documents/Prac/PDFReader/BankStatements/StandardBank.pdf"
        let tenantUrlString = setUpURL(pdfURL: pdfUrl)
        
        if let url = URL(string: tenantUrlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties: first_name -> firstName
                
                do {
                    let tenantData = try decoder.decode([TenantData].self, from: data)
//                    self?.tenantsData = tenantData
                    for tenant in tenantData {
                        print(tenant.reference)
                        print(tenant.amount)
                        print(tenant.date)
                        print("==================")
                    }
                } catch {
                    // Handle decoding error
                    print("Error parsing data: \(error)")
                }
            }
            .resume()
        } else {
            // Handle invalid URL
            print("Invalid URL")
        }
    }
}
