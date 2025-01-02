import SwiftUI

struct TenantListView: View {
    @StateObject var viewModel: TenantListViewModel

    init() {
        _viewModel = StateObject(wrappedValue: TenantListViewModel())
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                ScrollView {
                    ForEach(viewModel.allTenants) { tenant in
                        TenantInfoView(name: tenant.name,
                                       surname: tenant.surname,
                                       position: tenant.position,
                                       startDate: tenant.startDate.formatted(date: .abbreviated, time: .omitted),
                                       endDate: tenant.endDate.formatted(date: .abbreviated, time: .omitted))
                        .padding(.vertical)
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .navigationTitle("Tenants")
                .searchable(text: $viewModel.searchText, prompt: "Search Tenant")
                .navigationDestination(isPresented: $viewModel.showDetailView) {
                    TenantDetailView(tenant: Tennant(), unitNumber: "")
                }
            }
        }
    }
}

#Preview {
    TenantListView()
}
