import SwiftUI

struct MoodView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel
    @State private var showAddMood = false

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.moodEntries.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "face.smiling")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)

                        Text(NSLocalizedString("mood.track_title", comment: ""))
                            .font(.headline)

                        Text(NSLocalizedString("mood.track_subtitle", comment: ""))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Button(action: { showAddMood = true }) {
                            Label(NSLocalizedString("mood.add_entry", comment: ""), systemImage: "plus.circle.fill")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        Section(header: Text(NSLocalizedString("mood.recent_entries", comment: ""))) {
                            ForEach(viewModel.moodEntries) { entry in
                                MoodEntryRow(entry: entry)
                            }
                            .onDelete(perform: deleteMoodEntry)
                        }

                        // Mood Statistics
                        if viewModel.moodEntries.count >= 7 {
                            Section(header: Text(NSLocalizedString("mood.statistics", comment: ""))) {
                                MoodStatisticsView(entries: viewModel.moodEntries)
                            }
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("mood.title", comment: ""))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddMood = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddMood) {
                AddMoodView()
            }
        }
    }

    private func deleteMoodEntry(at offsets: IndexSet) {
        offsets.forEach { index in
            let entry = viewModel.moodEntries[index]
            viewModel.deleteMoodEntry(entry)
        }
    }
}

struct MoodEntryRow: View {
    let entry: MoodEntry

    var body: some View {
        HStack {
            Text(entry.mood.emoji)
                .font(.title)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.mood.localizedName)
                    .font(.headline)

                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)

                if let notes = entry.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct AddMoodView: View {
    @EnvironmentObject var viewModel: SobrietyViewModel
    @Environment(\.dismiss) var dismiss

    @State private var selectedMood: MoodEntry.Mood = .good
    @State private var notes = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(NSLocalizedString("mood.how_feeling", comment: ""))) {
                    Picker(NSLocalizedString("mood.how_feeling", comment: ""), selection: $selectedMood) {
                        ForEach(MoodEntry.Mood.allCases, id: \.self) { mood in
                            HStack {
                                Text(mood.emoji)
                                Text(mood.localizedName)
                            }
                            .tag(mood)
                        }
                    }
                    .pickerStyle(.inline)
                }

                Section(header: Text(NSLocalizedString("mood.notes", comment: ""))) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }

                Section {
                    Button(NSLocalizedString("save", comment: "")) {
                        let entry = MoodEntry(mood: selectedMood, notes: notes.isEmpty ? nil : notes)
                        viewModel.addMoodEntry(entry)
                        dismiss()
                    }
                }
            }
            .navigationTitle(NSLocalizedString("mood.add_title", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(NSLocalizedString("cancel", comment: "")) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct MoodStatisticsView: View {
    let entries: [MoodEntry]

    private var moodCounts: [MoodEntry.Mood: Int] {
        var counts: [MoodEntry.Mood: Int] = [:]
        for entry in entries {
            counts[entry.mood, default: 0] += 1
        }
        return counts
    }

    private var averageMood: String {
        let total = entries.reduce(0.0) { sum, entry in
            sum + entry.mood.numericValue
        }

        let average = total / Double(entries.count)

        if average >= 4.5 {
            return NSLocalizedString("mood.avg.excellent", comment: "")
        } else if average >= 3.5 {
            return NSLocalizedString("mood.avg.good", comment: "")
        } else if average >= 2.5 {
            return NSLocalizedString("mood.avg.okay", comment: "")
        } else if average >= 1.5 {
            return NSLocalizedString("mood.avg.bad", comment: "")
        } else {
            return NSLocalizedString("mood.avg.difficult", comment: "")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(NSLocalizedString("mood.average", comment: ""))
                    .foregroundColor(.secondary)
                Spacer()
                Text(averageMood)
                    .fontWeight(.semibold)
            }

            HStack {
                Text(NSLocalizedString("mood.total_entries", comment: ""))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(entries.count)")
                    .fontWeight(.semibold)
            }

            if let mostCommon = moodCounts.max(by: { $0.value < $1.value }) {
                HStack {
                    Text(NSLocalizedString("mood.most_common", comment: ""))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(mostCommon.key.emoji) \(mostCommon.key.localizedName)")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}
