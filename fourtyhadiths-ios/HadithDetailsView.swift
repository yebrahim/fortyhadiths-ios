import SwiftUI

struct HadithDetailsView: View {
  
  var index: Int
  var settings: Settings
  
  var body: some View {
    let idKey = "hadith\(index)Id"
    
    ScrollView(showsIndicators: false) {
      
      let font = settings.isArabic() ? alNileFont : englishFont
      let pre = localized("hadith\(index)Pre")
      let text = localized("hadith\(index)Text")
      let post = localized("hadith\(index)Post")
      
      VStack (alignment: .leading, spacing: 20) {
        Text(settings.hideDiacritics ? pre.removeDiacritics() : pre)
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
          .foregroundColor(.secondary)
        
        Text(settings.hideDiacritics ? text.removeDiacritics() : text)
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
        
        Text(settings.hideDiacritics ? post.removeDiacritics() : post)
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
          .foregroundColor(.secondary)
      }
      .padding()
    }
    .navigationTitle(LocalizedStringKey(idKey))
    .environment(\.layoutDirection, settings.isArabic() ? .rightToLeft : .leftToRight)
  }
  
  func localized(_ str: String) -> String {
    let path = Bundle.main.path(forResource: settings.locale, ofType: "lproj")
    let bundleName = Bundle(path: path!)
    return NSLocalizedString(str, tableName: nil, bundle: bundleName!, value: "", comment: "")
  }
}

extension String {
  func removeDiacritics() -> String {
    let regex = try! NSRegularExpression(pattern: "[\\u064b-\\u064f\\u0650-\\u0652]", options: NSRegularExpression.Options.caseInsensitive)
    let range = NSMakeRange(0, self.unicodeScalars.count)
    return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
  }
}

struct HadithDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    HadithDetailsView(index: 1, settings: Settings())
  }
}
