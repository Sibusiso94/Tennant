import Foundation
import RealmSwift

enum AddedObject {
    case property
    case tennant
}

class LandingViewModel: ObservableObject {
    @ObservedResults(Property.self) var properties
    @Published var newData: NewDataModel = NewDataModel()
    @Published var viewTitle: String = ""
    @Published var buttonTitle: String = ""
    
    let realmRepository: RealmRepository
    var newProperty: Property = Property()
    var newTennant: Tennant = Tennant()
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
    }
    
    func setUpView(isAProperty: Bool) {
        if isAProperty {
            viewTitle = "Add a Property"
//            buttonTitle = 
        }
    }
    
    func AddData(newData: NewDataModel) {
        if newData.isAProperty {
            Property(buildingName: newData.name,
                     buildingAddress: newData.address,
                     numberOfUnits: newData.numberOfUnits,
                     numberOfUnitsOccupied: newData.numberOfUnitsOccupied)
        } else {
            let date = Date.now
            Tennant(buildingNumber: newData.buildingNumber,
                    flatNumber: newData.flatNumber,
                    name: newData.name,
                    surname: newData.surname,
                    company: newData.company,
                    position: newData.position,
                    monthlyIncome: Int(newData.monthlyIncome) ?? 0,
                    balance: 0.0,
                    amountDue: 0.0, 
                    startDate: getCurrentDate(date: date),
                    endDate: getEndDate(date: date),
                    fullPayments: 0)
        }
    }
    
    private func getCurrentDate(date: Date) -> String {
        return date.getDateAsString()
    }
    
    private func getEndDate(date: Date) -> String {
        let dateInOneYear = Calendar.current.date(byAdding: .year, value: 1, to: date)
        return dateInOneYear?.getDateAsString() ?? date.getDateAsString()
    }
}
