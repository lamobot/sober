import Foundation

/// Core data model for sobriety tracking
struct SobrietyData: Codable {
    /// Date when user quit alcohol
    var sobrietyStartDate: Date

    /// Monthly alcohol expenses in EUR
    var monthlyAlcoholCost: Double

    /// Monthly related expenses (taxi, food, etc.) in EUR
    var monthlyRelatedCost: Double

    /// Days lost per month due to hangovers, recovery, etc.
    var monthlyTimeLostDays: Double

    // MARK: - Calculated Time Properties

    /// Total days of sobriety
    var daysSober: Int {
        Calendar.current.dateComponents([.day], from: sobrietyStartDate, to: Date()).day ?? 0
    }

    /// Total weeks of sobriety
    var weeksSober: Int {
        daysSober / 7
    }

    /// Total months of sobriety
    var monthsSober: Int {
        Calendar.current.dateComponents([.month], from: sobrietyStartDate, to: Date()).month ?? 0
    }

    /// Total years of sobriety
    var yearsSober: Int {
        Calendar.current.dateComponents([.year], from: sobrietyStartDate, to: Date()).year ?? 0
    }

    // MARK: - Financial Calculations

    /// Total money saved based on monthly costs
    var moneySaved: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        let monthsElapsed = Double(monthsSober)
        let additionalDays = Double(daysSober % 30)
        return (totalMonthlyCost * monthsElapsed) + (totalMonthlyCost / 30.0 * additionalDays)
    }

    /// Total time saved in days
    var timeSaved: Double {
        let monthsElapsed = Double(monthsSober)
        let additionalDays = Double(daysSober % 30)
        return (monthlyTimeLostDays * monthsElapsed) + (monthlyTimeLostDays / 30.0 * additionalDays)
    }

    /// Projected savings in 6 months
    var projectedSavings6Months: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        return totalMonthlyCost * 6
    }

    /// Projected savings in 12 months
    var projectedSavings12Months: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        return totalMonthlyCost * 12
    }

    // MARK: - Display Properties

    /// Localized time unit string (day/week/month/year)
    func displayTimeUnit(language: AppLanguage = LocalizationService.shared.currentLanguage) -> String {
        if yearsSober >= 1 {
            return yearsSober == 1 ? NSLocalizedString("time.year", comment: "") : NSLocalizedString("time.years", comment: "")
        } else if monthsSober >= 1 {
            return monthsSober == 1 ? NSLocalizedString("time.month", comment: "") : NSLocalizedString("time.months", comment: "")
        } else if weeksSober >= 1 {
            return weeksSober == 1 ? NSLocalizedString("time.week", comment: "") : NSLocalizedString("time.weeks", comment: "")
        } else {
            return daysSober == 1 ? NSLocalizedString("time.day", comment: "") : NSLocalizedString("time.days", comment: "")
        }
    }

    /// Value to display with the time unit
    var displayTimeValue: Int {
        if yearsSober >= 1 {
            return yearsSober
        } else if monthsSober >= 1 {
            return monthsSober
        } else if weeksSober >= 1 {
            return weeksSober
        } else {
            return daysSober
        }
    }
}
