import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel
    @State private var showResetAlert = false
    @State private var editMode = false

    // Edit state
    @State private var editStartDate = Date()
    @State private var editAlcoholCost = ""
    @State private var editRelatedCost = ""
    @State private var editTimeLost = ""

    @State private var notificationsEnabled = true
    @State private var notificationFrequency = Settings.NotificationFrequency.weekly

    var body: some View {
        NavigationView {
            Form {
                if !editMode {
                    // Display Mode
                    if let data = viewModel.sobrietyData {
                        Section(header: Text("Информация")) {
                            HStack {
                                Text("Дата начала")
                                Spacer()
                                Text(data.sobrietyStartDate, style: .date)
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text("Траты на алкоголь")
                                Spacer()
                                Text("\(String(format: "%.0f", data.monthlyAlcoholCost)) €/мес")
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text("Сопутствующие траты")
                                Spacer()
                                Text("\(String(format: "%.0f", data.monthlyRelatedCost)) €/мес")
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text("Потерянное время")
                                Spacer()
                                Text("\(String(format: "%.1f", data.monthlyTimeLostDays)) дней/мес")
                                    .foregroundColor(.secondary)
                            }
                        }

                        Section {
                            Button("Редактировать") {
                                startEditing(data)
                            }
                        }
                    }

                    Section(header: Text("Уведомления")) {
                        Toggle("Включить уведомления", isOn: $notificationsEnabled)
                            .onChange(of: notificationsEnabled) { newValue in
                                var settings = viewModel.settings
                                settings.notificationsEnabled = newValue
                                viewModel.updateSettings(settings)
                            }

                        if notificationsEnabled {
                            Picker("Частота", selection: $notificationFrequency) {
                                ForEach(Settings.NotificationFrequency.allCases, id: \.self) { freq in
                                    Text(freq.localizedName).tag(freq)
                                }
                            }
                            .onChange(of: notificationFrequency) { newValue in
                                var settings = viewModel.settings
                                settings.notificationFrequency = newValue
                                viewModel.updateSettings(settings)
                            }
                        }
                    }

                    Section(header: Text("Данные")) {
                        Button("Сбросить все данные", role: .destructive) {
                            showResetAlert = true
                        }
                    }

                    Section(header: Text("О приложении")) {
                        HStack {
                            Text("Версия")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.secondary)
                        }

                        Link("Поддержка", destination: URL(string: "https://github.com/vtoropov/sober")!)
                    }
                } else {
                    // Edit Mode
                    Section(header: Text("Редактирование данных")) {
                        DatePicker("Дата начала",
                                  selection: $editStartDate,
                                  in: ...Date(),
                                  displayedComponents: .date)

                        HStack {
                            Text("€")
                                .foregroundColor(.secondary)
                            TextField("Траты на алкоголь", text: $editAlcoholCost)
                                .keyboardType(.decimalPad)
                        }

                        HStack {
                            Text("€")
                                .foregroundColor(.secondary)
                            TextField("Сопутствующие траты", text: $editRelatedCost)
                                .keyboardType(.decimalPad)
                        }

                        HStack {
                            TextField("Потерянное время", text: $editTimeLost)
                                .keyboardType(.decimalPad)
                            Text("дней")
                                .foregroundColor(.secondary)
                        }
                    }

                    Section {
                        Button("Сохранить") {
                            saveEdits()
                        }

                        Button("Отмена", role: .cancel) {
                            editMode = false
                        }
                    }
                }
            }
            .navigationTitle("Настройки")
            .onAppear {
                notificationsEnabled = viewModel.settings.notificationsEnabled
                notificationFrequency = viewModel.settings.notificationFrequency
            }
            .alert("Сброс данных", isPresented: $showResetAlert) {
                Button("Отмена", role: .cancel) {}
                Button("Сбросить", role: .destructive) {
                    viewModel.resetAllData()
                }
            } message: {
                Text("Вы уверены? Все данные будут удалены безвозвратно.")
            }
        }
    }

    private func startEditing(_ data: SobrietyData) {
        editStartDate = data.sobrietyStartDate
        editAlcoholCost = String(format: "%.0f", data.monthlyAlcoholCost)
        editRelatedCost = String(format: "%.0f", data.monthlyRelatedCost)
        editTimeLost = String(format: "%.1f", data.monthlyTimeLostDays)
        editMode = true
    }

    private func saveEdits() {
        guard let alcoholCost = Double(editAlcoholCost),
              let relatedCost = Double(editRelatedCost),
              let timeLost = Double(editTimeLost) else {
            return
        }

        let updatedData = SobrietyData(
            sobrietyStartDate: editStartDate,
            monthlyAlcoholCost: alcoholCost,
            monthlyRelatedCost: relatedCost,
            monthlyTimeLostDays: timeLost
        )

        viewModel.saveSobrietyData(updatedData)
        editMode = false
    }
}
