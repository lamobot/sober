import Foundation

struct SobrietyData: Codable {
    var sobrietyStartDate: Date
    var monthlyAlcoholCost: Double // in EUR
    var monthlyRelatedCost: Double // in EUR (taxi, etc.)
    var monthlyTimeLostDays: Double // days lost per month

    // Calculated properties
    var daysSober: Int {
        Calendar.current.dateComponents([.day], from: sobrietyStartDate, to: Date()).day ?? 0
    }

    var weeksSober: Int {
        daysSober / 7
    }

    var monthsSober: Int {
        Calendar.current.dateComponents([.month], from: sobrietyStartDate, to: Date()).month ?? 0
    }

    var yearsSober: Int {
        Calendar.current.dateComponents([.year], from: sobrietyStartDate, to: Date()).year ?? 0
    }

    var moneySaved: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        let monthsElapsed = Double(monthsSober)
        let additionalDays = Double(daysSober % 30)
        return (totalMonthlyCost * monthsElapsed) + (totalMonthlyCost / 30.0 * additionalDays)
    }

    var timeSaved: Double {
        let monthsElapsed = Double(monthsSober)
        let additionalDays = Double(daysSober % 30)
        return (monthlyTimeLostDays * monthsElapsed) + (monthlyTimeLostDays / 30.0 * additionalDays)
    }

    var projectedSavings6Months: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        return totalMonthlyCost * 6
    }

    var projectedSavings12Months: Double {
        let totalMonthlyCost = monthlyAlcoholCost + monthlyRelatedCost
        return totalMonthlyCost * 12
    }

    var displayTimeUnit: String {
        if yearsSober >= 1 {
            return yearsSober == 1 ? "год" : yearsSober < 5 ? "года" : "лет"
        } else if monthsSober >= 1 {
            return monthsSober == 1 ? "месяц" : monthsSober < 5 ? "месяца" : "месяцев"
        } else if weeksSober >= 1 {
            return weeksSober == 1 ? "неделя" : weeksSober < 5 ? "недели" : "недель"
        } else {
            return daysSober == 1 ? "день" : daysSober < 5 ? "дня" : "дней"
        }
    }

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
