struct TenantStrings {
    enum PropertyInfo: String {
        case image = "building.2"
        case mainTitle = "Propery Information"
        case propertyName = "Property name"
        case unitNumber = "Unit Number"
    }

    enum EmploymentInfo: String {
        case image = "suitcase"
        case mainTitle = "Employment Information"
        case company = "Company"
        case position = "Position"
        case monthlyIncome = "Monthly Income"
    }

    enum FinancialOverview: String {
        case image = "wallet.bifold"
        case mainTitle = "Financial Overview"
        case balance = "Balance"
        case amountDue = "Amount Due"
    }

    enum TenancyPeriod: String {
        case image = "calendar.badge.clock"
        case mainTitle = "Tenancy Period"
        case startDate = "Start Date"
        case endDate = "End Date"
    }
}
