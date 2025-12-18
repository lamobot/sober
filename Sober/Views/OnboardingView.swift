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
                Section(header: Text("Добро пожаловать в Sober")) {
                    Text("Начните свой путь к здоровой жизни")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Section(header: Text("Дата начала")) {
                    DatePicker("Дата отказа от алкоголя",
                              selection: $sobrietyStartDate,
                              in: ...Date(),
                              displayedComponents: .date)
                }

                Section(header: Text("Финансовые параметры")) {
                    HStack {
                        Text("€")
                            .foregroundColor(.secondary)
                        TextField("Траты на алкоголь в месяц", text: $monthlyAlcoholCost)
                            .keyboardType(.decimalPad)
                    }

                    HStack {
                        Text("€")
                            .foregroundColor(.secondary)
                        TextField("Сопутствующие траты в месяц", text: $monthlyRelatedCost)
                            .keyboardType(.decimalPad)
                    }

                    Text("Например: такси, еда, клубы и т.д.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section(header: Text("Потерянное время")) {
                    HStack {
                        TextField("Дни в месяц", text: $monthlyTimeLostDays)
                            .keyboardType(.decimalPad)
                        Text("дней")
                            .foregroundColor(.secondary)
                    }

                    Text("Похмелье, восстановление и т.д.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section {
                    Button(action: saveAndStart) {
                        HStack {
                            Spacer()
                            Text("Начать")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Настройка")
            .alert("Ошибка", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Пожалуйста, заполните все поля корректно")
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
