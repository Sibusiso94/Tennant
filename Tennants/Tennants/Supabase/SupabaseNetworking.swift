import Foundation
import SwiftUI
import Supabase

enum Table {
    static let tests = "test"
}

enum RefTable {
    static let ref = "references"
}

enum AuthAction: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

class SupabaseNetworking {
    var email = "test@gmail.com"
    var password = "Password1"
    var isAuthenticated = false
    var authAction: AuthAction = .signUp

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

    func createReference(/*_ references: [String]*/) async throws {
        let user = try await supabase.auth.session.user

        let ref = Reference(unitId: "unit 1", tenantId: "Shivon", reference: "Shivon1", userID: user.id)
        print(ref)
        try await supabase.database
            .from(RefTable.ref)
            .insert(ref)
            .execute()
    }

    func fecthRequests() async throws {
        let tests : [Reference] = try await supabase
            .from(RefTable.ref)
            .select()
            .execute()
            .value

        print("+++++++++++++++++++++")
        print(tests)
    }

    func signUp() async throws {
//        if let
        let response = try await supabase.auth.signIn(email: email, password: password)
        print(response.accessToken)
        print(response.user)
    }

    func signIn() async throws {
        let session = try await supabase.auth.signIn(email: email, password: password)
    }

    func isUserAuthenticated() async {
        do {
            _ = try await supabase.auth.session.user
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
    }

    func signOut() async throws {
        try await supabase.auth.signOut()
        isAuthenticated = false
    }

    func authorise() async throws {
        switch authAction {
        case .signUp:
            try await signUp()
        case .signIn:
            try await signIn()
        }
    }
}
