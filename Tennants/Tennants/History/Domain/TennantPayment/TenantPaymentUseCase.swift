import Foundation
import OSLog

class TenantPaymentUseCase: TenantPaymentProtocol {
    private let apiManager: APIManager
    private let supabase: SupabaseNetworkingProtocol

    private var fileSoragePath: String?
    var errorMessage: String = ""
    var isCompleteUploading = false

    init(apiManager: APIManager,
         supabase: SupabaseNetworkingProtocol) {
        self.apiManager = apiManager
        self.supabase = supabase
    }

    func getPaymentData(
        selectedBankType: String,
        userId: String
    ) async throws -> [TenantPaymentData] {
        do {
            guard let storagePath = fileSoragePath else { return [] }
            return try await apiManager.fetchApiData(
                selectedBankType: selectedBankType,
                userId: userId,
                storagePath: storagePath
            )
        } catch {
            throw error
        }
    }

    func handleImportedFile(
        url: URL,
        selectedBankType: String,
        userId: String
    ) async throws {
        fileSoragePath = setUpStoragePath(userId, selectedBankType)

        do {
            let data = try Data(contentsOf: url)
            guard let storagePath = fileSoragePath else { return }
            try await supabase.uploadFile(
                fileData: data,
                storagePath: storagePath,
                selectedBankType: selectedBankType
            )
            print("file uploaded")
            isCompleteUploading = true
        } catch {
            os_log("Error reading file data: %@", type: .debug, error.localizedDescription)
            errorMessage = FileErrorMessages.failedToFetchFile.rawValue
        }
    }

    private func validateFileURL(_ fileURL: URL) throws -> Bool {
        let fileManager = FileManager.default

        guard fileURL.isFileURL else {
            os_log("The URL is not a file URL.", type: .debug)
            throw ApiError.fileValidationFailure
        }

        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                os_log("The URL is a directory.", type: .debug)
                throw ApiError.fileValidationFailure
            }

            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                os_log("The URL is a symbolic link.", type: .debug)
                throw ApiError.fileValidationFailure
            }
            
            return true
        } catch {
            os_log("The URL is invalid or cannot be accessed:", type: .debug, error.localizedDescription)
            throw ApiError.fileValidationFailure
        }
    }

    private func setUpStoragePath(_ userId: String, _ selectedBankType: String) -> String {
        let date = Date.now
        let day = date.formatted(.dateTime.weekday(.twoDigits))
        let month = date.formatted(.dateTime.month(.twoDigits))
        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
        return "statements/\(userId)/\(day)_\(month)_\(year)_\(selectedBankType)_statement.pdf"
    }
}
