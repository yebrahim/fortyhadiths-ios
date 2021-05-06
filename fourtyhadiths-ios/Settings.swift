import SwiftUI

class Settings: ObservableObject {
  
  static let defaultLocale = Locale.current.languageCode!
  static let defaultFontSize = 22.0
  static let languageStoreKey = "SETTINGS_LANGUAGE"
  static let fontSizeStoreKey = "SETTINGS_FONTSIZE"
  static let hideDiacriticsStoreKey = "SETTINGS_HIDE_DIACRITICS"
  
  let locales = ["en": "English", "ar": "العربية"]
  let minFontSize = 10.0
  let maxFontSize = 40.0
  
  @Published
  var locale = UserDefaults.standard.string(forKey: languageStoreKey) ?? defaultLocale
  
  @Published
  var fontSize = UserDefaults.standard.double(forKey: fontSizeStoreKey) <= 0 ? defaultFontSize : UserDefaults.standard.double(forKey: fontSizeStoreKey)
  
  @Published
  var hideDiacritics = UserDefaults.standard.bool(forKey: hideDiacriticsStoreKey)
  
  func getLocales() -> Array<(key: String, value: String)> {
    isArabic() ? locales.sorted(by: <) : locales.sorted(by: >)
  }
  
  func isArabic() -> Bool {
    locale == "ar"
  }
  
  func calcFontSize() -> Double {
    isArabic() ? fontSize + 10 : fontSize
  }
}
