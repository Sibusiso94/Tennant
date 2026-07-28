import SwiftUI

struct TenantListView: View {
    @Bindable var viewModel: TenantListViewModel

    init(viewModel: TenantListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
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
                    .onTapGesture {
                        viewModel.didSelectTenant(tenant)
                    }
                }
            }
            .navigationTitle("Tenants")
            .searchable(text: $viewModel.searchText, prompt: "Search Tenant")
        }
    }
}
