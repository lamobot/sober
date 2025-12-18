import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel
    @StateObject private var localizationService = LocalizationService.shared
    
    @State private var showResetAlert = false
    @State private var editMode = false
    @State private var selectedLanguage = LocalizationService.shared.currentLanguage

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
                        Section(header: Text(NSLocalizedString("settings.info", comment: ""))) {
                            HStack {
                                Text(NSLocalizedString("settings.start_date", comment: ""))
                                Spacer()
                                Text(data.sobrietyStartDate, style: .date)
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text(NSLocalizedString("settings.alcohol_cost", comment: ""))
                                Spacer()
                                Text("\(String(format: "%.0f", data.monthlyAlcoholCost)) €/\(NSLocalizedString("time.month", comment: ""))")
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text(NSLocalizedString("settings.related_cost", comment: ""))
                                Spacer()
                                Text("\(String(format: "%.0f", data.monthlyRelatedCost)) €/\(NSLocalizedString("time.month", comment: ""))")
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                Text(NSLocalizedString("settings.time_lost", comment: ""))
                                Spacer()
                                Text("\(String(format: "%.1f", data.monthlyTimeLostDays)) \(NSLocalizedString("currency.days", comment: ""))/\(NSLocalizedString("time.month", comment: ""))")
                                    .foregroundColor(.secondary)
                            }
                        }

                        Section {
                            Button(NSLocalizedString("settings.edit_data", comment: "")) {
                                startEditing(data)
                            }
                        }
                    }

                    // Language Picker
                    Section(header: Text(NSLocalizedString("settings.language", comment: ""))) {
                        Picker(NSLocalizedString("settings.language", comment: ""),
                               selection: $selectedLanguage) {
                            ForEach(AppLanguage.allCases, id: \.self) { language in
                                Text(language.displayName).tag(language)
                            }
                        }
                        .onChange(of: selectedLanguage) { newLanguage in
                            LocalizationService.shared.currentLanguage = newLanguage
                            var settings = viewModel.settings
                            settings.selectedLanguage = newLanguage.rawValue
                            viewModel.updateSettings(settings)
                        }
                    }

                    Section(header: Text(NSLocalizedString("settings.notifications", comment: ""))) {
                        Toggle(NSLocalizedString("settings.notifications_enable", comment: ""), isOn: $notificationsEnabled)
                            .onChange(of: notificationsEnabled) { newValue in
                                var settings = viewModel.settings
                                settings.notificationsEnabled = newValue
                                viewModel.updateSettings(settings)
                            }

                        if notificationsEnabled {
                            Picker(NSLocalizedString("settings.notifications_frequency", comment: ""), selection: $notificationFrequency) {
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

                    Section(header: Text(NSLocalizedString("settings.data", comment: ""))) {
                        Button(NSLocalizedString("settings.reset_data", comment: ""), role: .destructive) {
                            showResetAlert = true
                        }
                    }

                    Section(header: Text(NSLocalizedString("settings.about", comment: ""))) {
                        HStack {
                            Text(NSLocalizedString("settings.version", comment: ""))
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.secondary)
                        }

                        Link(NSLocalizedString("settings.support", comment: ""), destination: URL(string: "https://github.com/lamobot/sober")!)
                    }
                } else {
                    // Edit Mode
                    Section(header: Text(NSLocalizedString("settings.edit_data", comment: ""))) {
                        DatePicker(NSLocalizedString("settings.start_date", comment: ""),
                                  selection: $editStartDate,
                                  in: ...Date(),
                                  displayedComponents: .date)

                        HStack {
                            Text("€")
                                .foregroundColor(.secondary)
                            TextField(NSLocalizedString("settings.alcohol_cost", comment: ""), text: $editAlcoholCost)
                                .keyboardType(.decimalPad)
                        }

                        HStack {
                            Text("€")
                                .foregroundColor(.secondary)
                            TextField(NSLocalizedString("settings.related_cost", comment: ""), text: $editRelatedCost)
                                .keyboardType(.decimalPad)
                        }

                        HStack {
                            TextField(NSLocalizedString("settings.time_lost", comment: ""), text: $editTimeLost)
                                .keyboardType(.decimalPad)
                            Text(NSLocalizedString("currency.days", comment: ""))
                                .foregroundColor(.secondary)
                        }
                    }

                    Section {
                        Button(NSLocalizedString("save", comment: "")) {
                            saveEdits()
                        }

                        Button(NSLocalizedString("cancel", comment: ""), role: .cancel) {
                            editMode = false
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("settings.title", comment: ""))
            .onAppear {
                notificationsEnabled = viewModel.settings.notificationsEnabled
                notificationFrequency = viewModel.settings.notificationFrequency
            }
            .alert(NSLocalizedString("settings.reset_alert", comment: ""), isPresented: $showResetAlert) {
                Button(NSLocalizedString("cancel", comment: ""), role: .cancel) {}
                Button(NSLocalizedString("settings.reset_data", comment: ""), role: .destructive) {
                    viewModel.resetAllData()
                }
            } message: {
                Text(NSLocalizedString("settings.reset_message", comment: ""))
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
