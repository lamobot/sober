import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel
    @State private var sobrietyStartDate = Date()
    @State private var monthlyAlcoholCost = ""
    @State private var monthlyRelatedCost = ""
    @State private var monthlyTimeLostDays = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(NSLocalizedString("onboarding.title", comment: ""))) {
                    Text(NSLocalizedString("onboarding.subtitle", comment: ""))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Section(header: Text(NSLocalizedString("onboarding.start_date", comment: ""))) {
                    DatePicker(NSLocalizedString("onboarding.quit_date", comment: ""),
                              selection: $sobrietyStartDate,
                              in: ...Date(),
                              displayedComponents: .date)
                }

                Section(header: Text(NSLocalizedString("onboarding.financial_params", comment: ""))) {
                    HStack {
                        Text("€")
                            .foregroundColor(.secondary)
                        TextField(NSLocalizedString("onboarding.alcohol_cost", comment: ""), text: $monthlyAlcoholCost)
                            .keyboardType(.decimalPad)
                    }

                    HStack {
                        Text("€")
                            .foregroundColor(.secondary)
                        TextField(NSLocalizedString("onboarding.related_cost", comment: ""), text: $monthlyRelatedCost)
                            .keyboardType(.decimalPad)
                    }

                    Text(NSLocalizedString("onboarding.related_hint", comment: ""))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section(header: Text(NSLocalizedString("onboarding.time_lost", comment: ""))) {
                    HStack {
                        TextField(NSLocalizedString("onboarding.time_lost_placeholder", comment: ""), text: $monthlyTimeLostDays)
                            .keyboardType(.decimalPad)
                        Text(NSLocalizedString("currency.days", comment: ""))
                            .foregroundColor(.secondary)
                    }

                    Text(NSLocalizedString("onboarding.time_lost_hint", comment: ""))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section {
                    Button(action: saveAndStart) {
                        HStack {
                            Spacer()
                            Text(NSLocalizedString("onboarding.start", comment: ""))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("settings.title", comment: ""))
            .alert(NSLocalizedString("onboarding.error", comment: ""), isPresented: $showError) {
                Button(NSLocalizedString("ok", comment: ""), role: .cancel) {}
            } message: {
                Text(NSLocalizedString("onboarding.error_message", comment: ""))
            }
        }
    }

    private func saveAndStart() {
        guard let alcoholCost = Double(monthlyAlcoholCost),
              let relatedCost = Double(monthlyRelatedCost),
              let timeLost = Double(monthlyTimeLostDays),
              alcoholCost >= 0,
              relatedCost >= 0,
              timeLost >= 0 else {
            showError = true
            return
        }

        let data = SobrietyData(
            sobrietyStartDate: sobrietyStartDate,
            monthlyAlcoholCost: alcoholCost,
            monthlyRelatedCost: relatedCost,
            monthlyTimeLostDays: timeLost
        )

        viewModel.saveSobrietyData(data)
    }
}
