import Foundation
import SwiftUI
import Supabase
import OSLog

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
    var storagePath = "userId/statement.pdf"

    private let supabase = SupabaseClient(supabaseURL: Secrets.projectUrl, supabaseKey: Secrets.apikey)
    private let bucketName = "Statements"

    lazy var supabaseStorage =  SupabaseStorageClient(configuration: StorageClientConfiguration(url: Secrets.storageUrl, headers: ["Authorization": "Bearer \(Secrets.serviceRole)", "apikey": Secrets.apikey]))

    func uploadFile(fileData: Data, userId: String, selectedBankType: String) async throws {
        storagePath = setUpStoragePath(userId, selectedBankType)

        do {
            try await supabaseStorage
                .from("Statement")
                .upload(
                    storagePath,
                    data: fileData,
                    options: FileOptions(
                        cacheControl: "3600",
                        contentType: "application/pdf",
                        upsert: false
                    )
                )
        } catch {
            os_log("failed to upload pdf: %@", type: .debug, error.localizedDescription)
        }
    }

    func createReference(unitId: String, tenantId: String, reference: String/*, userID: UUID*/) async throws {
        let user = try await supabase.auth.session.user

        let ref = Reference(unitId: unitId, tenantId: tenantId, reference: reference, userID: user.id)
        try await supabase.database
            .from(RefTable.ref)
            .insert(ref)
            .execute()
    }

    func fecthRequests() async throws {
        let reference: [Reference] = try await supabase
            .from(RefTable.ref)
            .select()
            .execute()
            .value
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

    internal func setUpStoragePath(_ userId: String, _ selectedBankType: String) -> String {
        let date = Date.now
        let day = date.formatted(.dateTime.weekday(.twoDigits))
        let month = date.formatted(.dateTime.month(.twoDigits))
        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
        return "statements/\(userId)/\(day)_\(month)_\(year)_\(selectedBankType)_statement.pdf"
    }
}
