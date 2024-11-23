import Foundation
import SwiftUI
import Supabase

enum Table {
    static let tests = "test"
}

class SupabaseNetworking {
    var email = "test@gmail.com"
    var password = "Passowrd1"

    private let supabase = SupabaseClient(supabaseURL: Secrets.projectUrl, supabaseKey: Secrets.apikey)
    private let bucketName = "Statements"

    lazy var supabaseStorage =  SupabaseStorageClient(configuration: StorageClientConfiguration(url: Secrets.storageUrl, headers: ["Authorization": "Bearer \(Secrets.serviceRole)", "apikey": Secrets.apikey]))

    func uploadFile(fileData: Data, userId: String) async throws {
        let fileName = "statement.pdf"

        do {
            try await supabaseStorage
                .from("Statement")
                .upload(
                    "\(userId)/\(fileName)",
                    data: fileData,
                    options: FileOptions(
                        cacheControl: "3600",
                        contentType: "application/pdf",
                        upsert: false
                    )
                )
        } catch {
            print("==============")
            print(error)
        }
    }

    func fecthRequests() async throws {
        let tests : [Test] = try await supabase.database
            .from(Table.tests)
            .select()
            .order("created_at", ascending: false)
            .execute()
            .value

        print("+++++++++++++++++++++")
        print(tests)
    }
}
