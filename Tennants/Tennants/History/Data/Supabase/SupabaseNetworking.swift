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

protocol SupabaseNetworkingProtocol {
    func uploadFile(fileData: Data, storagePath: String, selectedBankType: String) async throws
    func signUp() async throws
    func signIn() async throws
    func signOut() async throws
    func isUserAuthenticated() async
    func authorise() async throws
}

class SupabaseNetworking: SupabaseNetworkingProtocol {
    var email = "test@gmail.com"
    var password = "Password1"
    var isAuthenticated = false
    var authAction: AuthAction = .signUp
    var storagePath = "userId/statement.pdf"

    private let supabase = SupabaseClient(supabaseURL: Secrets.projectUrl, supabaseKey: Secrets.apikey)
    private let bucketName = "Statement"

    func uploadFile(fileData: Data, storagePath: String, selectedBankType: String) async throws {
        // Storage RLS is evaluated against the caller's JWT, so we must be
        // signed in as a real user before uploading (the publishable key alone
        // is the `anon` role and will be rejected by RLS).
        try await ensureSignedIn()

        do {
            try await supabase.storage
                .from(bucketName)
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
            throw error
        }
    }

    private func ensureSignedIn() async throws {
        let hasSession = (try? await supabase.auth.session) != nil
        if !hasSession {
            try await signIn()
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
}
