import SwiftUI

struct HadithDetailsView: View {
  
  var index: Int
  var settings: Settings

  var body: some View {
    let idKey = "hadith\(index)Id"

    ScrollView {
      
      let preKey = "hadith\(index)Pre"
      let textKey = "hadith\(index)Text"
      let PostKey = "hadith\(index)Post"

      VStack (alignment: .leading, spacing: 20) {
        Text(LocalizedStringKey(preKey))
          .multilineTextAlignment(.leading)
          .font(.system(size: CGFloat(settings.fontSize)))
          .foregroundColor(.secondary)
        
        Text(LocalizedStringKey(textKey))
          .multilineTextAlignment(.leading)
          .font(.system(size: CGFloat(settings.fontSize)))
        
        Text(LocalizedStringKey(PostKey))
          .multilineTextAlignment(.leading)
          .font(.system(size: CGFloat(settings.fontSize)))
          .foregroundColor(.secondary)
      }
      .padding()
    }
    .navigationTitle(LocalizedStringKey(idKey))
  }
}

struct HadithDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    HadithDetailsView(index: 1, settings: Settings())
  }
}
