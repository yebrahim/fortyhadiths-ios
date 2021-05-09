import SwiftUI

struct HadithItem: View {
  @ObservedObject var settings: Settings
  var index: Int
  
  var body: some View {
    let hadithIdFont = settings.isArabic() ? thuluthFont : alNileFont
    let hadithSummaryFont = settings.isArabic() ? alNileFontBold : englishFontBold
    let hadithIdFontSize = settings.isArabic() ? CGFloat(25) : CGFloat(14)
    
    HStack(alignment: .top) {
      ZStack {
        Circle().fill(Color.accentColor).frame(width: 30)
        Text("\(index)")
          .foregroundColor(.white)
          .fontWeight(.bold)
      }
      .padding(.vertical)
      
      VStack (alignment: .leading) {
        let hadithId = localized("hadith\(index)Id")
        let hadithSummary = localized("hadith\(index)Summary")
        
        Text(hadithId)
          .font(.custom(hadithIdFont, size: hadithIdFontSize, relativeTo: .footnote))
          .foregroundColor(.secondary)
        
        Text(settings.hideDiacritics ? hadithSummary.removeDiacritics() : hadithSummary)
          .font(.custom(hadithSummaryFont, size: 0.8 * CGFloat(settings.calcFontSize())))
          .foregroundColor(.primary)
      }
    }
    .contentShape(Rectangle())
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(5)
  }
  
  func localized(_ str: String) -> String {
    let path = Bundle.main.path(forResource: settings.locale, ofType: "lproj")
    let bundleName = Bundle(path: path!)
    return NSLocalizedString(str, tableName: nil, bundle: bundleName!, value: "", comment: "")
  }
}
