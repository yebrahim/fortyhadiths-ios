import SwiftUI

struct HadithDetailsView: View {
  
  let arabicFont = "AlNile"
  let englishFont = "TrebuchetMs"
  var index: Int
  var settings: Settings

  var body: some View {
    let idKey = "hadith\(index)Id"

    ScrollView(showsIndicators: false) {
      
      let font = settings.isArabic() ? arabicFont : englishFont
      let preKey = "hadith\(index)Pre"
      let textKey = "hadith\(index)Text"
      let PostKey = "hadith\(index)Post"

      VStack (alignment: .leading, spacing: 20) {
        Text(LocalizedStringKey(preKey))
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
          .foregroundColor(.secondary)
        
        Text(LocalizedStringKey(textKey))
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
        
        Text(LocalizedStringKey(PostKey))
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
          .foregroundColor(.secondary)
      }
      .padding()
    }
    .navigationTitle(LocalizedStringKey(idKey))
    .environment(\.layoutDirection, settings.isArabic() ? .rightToLeft : .leftToRight)
  }
}

struct HadithDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    HadithDetailsView(index: 1, settings: Settings())
  }
}
