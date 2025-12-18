import Foundation
import SwiftUI
import Combine

// Language manager for app localization
class LocalizationService: ObservableObject {
    static let shared = LocalizationService()

    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "appLanguage")
            updateBundle()
        }
    }

    private var bundle: Bundle?

    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage")
        if let savedLanguage = savedLanguage, let language = AppLanguage(rawValue: savedLanguage) {
            self.currentLanguage = language
        } else {
            // Auto-detect system language
            let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            self.currentLanguage = systemLanguage.hasPrefix("ru") ? .russian : .english
        }
        updateBundle()
    }

    private func updateBundle() {
        if let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
            Bundle.setLanguage(currentLanguage.rawValue)
        } else {
            self.bundle = Bundle.main
        }
    }

    func localized(_ key: String) -> String {
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
    }
}

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case russian = "ru"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .russian: return "Русский"
        }
    }

    var locale: Locale {
        return Locale(identifier: rawValue)
    }
}

// Helper function for localization
func L(_ key: String) -> String {
    return LocalizationService.shared.localized(key)
}

// Extension for String localization
extension String {
    func localized() -> String {
        return LocalizationService.shared.localized(self)
    }
}

// Bundle extension for runtime language switching
private var bundleKey: UInt8 = 0

extension Bundle {
    @objc func specialLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle {
            return bundle.specialLocalizedString(forKey: key, value: value, table: tableName)
        } else {
            return self.specialLocalizedString(forKey: key, value: value, table: tableName)
        }
    }

    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, PrivateBundle.self)
        }

        objc_removeAssociatedObjects(Bundle.main)

        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private class PrivateBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

// Extension to get string from LocalizedStringKey
extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}
