import SwiftUI

struct HadithDetailsView: View {
  
  @State var index: Int
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
        
        Divider()

        Text(settings.hideDiacritics ? post.removeDiacritics() : post)
          .multilineTextAlignment(.leading)
          .font(.custom(font, size: CGFloat(settings.calcFontSize())))
          .foregroundColor(.secondary)

        HStack {
          StepperButton(forward: false, disabled: index < 2) {
            index -= 1
          }

          Spacer()

          StepperButton(forward: true, disabled: index >= 42) {
            index += 1
          }
        }
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

struct StepperButton: View {

  let size: CGFloat = 40

  var forward: Bool
  var disabled: Bool
  var action: () -> Void

  var body: some View {
    Button(action: action) {
      Image(systemName: "chevron.\(forward ? "forward" : "backward").circle.fill")
        .resizable()
        .frame(width: size, height: size)
        .foregroundColor(.accentColor)
    }
    .padding()
    .disabled(disabled)
  }
}
