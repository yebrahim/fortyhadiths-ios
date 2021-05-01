import SwiftUI

class Settings: ObservableObject {
  
  static var defaultLocale = Locale.current.languageCode!
  static let defaultFontSize = 17.0

  let locales = ["en": "English", "ar": "Arabic"]
  let minFontSize = 10.0
  let maxFontSize = 40.0

  @Published
  var locale = defaultLocale
  
  @Published
  var fontSize = defaultFontSize
}
