import Foundation
import RealmSwift

class Tennant: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var flatID: String
    @Persisted var name: String
    @Persisted var surname: String
    @Persisted var company : String
    @Persisted var position: String
    @Persisted var annualIncome: Int
    @Persisted var balance: Int
    @Persisted var amountDue: Int
    @Persisted var startDate: String
    @Persisted var endDate: String
    
    convenience init(id: String = UUID().uuidString, 
                     flatID: String,
                     name: String,
                     surname: String,
                     company : String,
                     position: String,
                     annualIncome: Int,
                     balance: Int, 
                     amountDue: Int,
                     startDate: String,
                     endDate: String) {
        self.flatID = flatID
        self.name = name
        self.surname = surname
        self.company = company
        self.position = position
        self.annualIncome = annualIncome
        self.balance = balance
        self.amountDue = amountDue
        self.startDate = startDate
        self.endDate = endDate
    }
}

class TennantBuilder {
    var tennant = Tennant()
    
    func works(_ tennant: Tennant) -> TennantJobBuilder {
        TennantJobBuilder(tennant)
    }
    
    func earns(annualIncome: Int) -> TennantBuilder {
        tennant.annualIncome = annualIncome
        return self
    }
    
    func build() -> Tennant {
        return tennant
    }
}

class TennantJobBuilder: TennantBuilder {
    internal init(_ tennant: Tennant) {
        super.init()
        self.tennant = tennant
    }
    
    func at(company: String) -> TennantBuilder {
        tennant.company = company
        return self
    }
    
    func asA(position: String) -> TennantBuilder {
        tennant.position = position
        return self
    }
}

Object, Identifiable {
    @Persisted(primaryKey: true) var userID = UUID().uuidString
    @Persisted var email: String
    @Persisted var profileAvatar: String?
    @Persisted var username: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var wishlistItems: List<WishlistRealmModel> = List<WishlistRealmModel>()
    @Persisted var lookBookItems: List<LookbookRealmModel> = List<LookbookRealmModel>()
    @Persisted var generatedLooks: List<GeneratedLooksRealmModel> = List<GeneratedLooksRealmModel>()
    @Persisted var fashionLibrary: List<FashionLibraryRealmModel> = List<FashionLibraryRealmModel>()
    @Persisted var premiumFashionLibrary: List<PremiumFashionLibraryRealmModel> = List<PremiumFashionLibraryRealmModel>()
    
    convenience init(userID: String = UUID().uuidString,
                     email: String,
                     profileAvatar: String? = nil,
                     username: String,
                     firstName: String,
                     lastName: String,
                     wishlistItems: List<WishlistRealmModel> = List<WishlistRealmModel>(),
                     lookBookItems: List<LookbookRealmModel> = List<LookbookRealmModel>(),
                     generatedLooks: List<GeneratedLooksRealmModel> = List<GeneratedLooksRealmModel>(),
                     fashionLibrary: List<FashionLibraryRealmModel> = List<FashionLibraryRealmModel>(),
                     premiumFashionLibrary: List<PremiumFashionLibraryRealmModel> = List<PremiumFashionLibraryRealmModel>()) {
        self.init()
        self.userID = userID
        self.email = email
