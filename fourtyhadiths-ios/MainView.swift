import SwiftUI

let thuluthFont = "Diwan Thuluth"
let alNileFont = "AlNile"
let alNileFontBold = "AlNile-Bold"
let englishFont = "AppleSymbols"
let englishFontBold = "AlNile-Bold"
let englishDecoratedFont = "Georgia-Italic"

struct MainView: View {
  
  @ObservedObject
  var settings = Settings()
  
  @State var showSettings = false
  
  var body: some View {
    RtlNavigationView(settings: settings) {
      ScrollView(showsIndicators: false) {
        
        CoverHadith(settings: settings)
        
        Divider().frame(width: 50).padding()
        
        VStack {
          ForEach(1...42, id: \.self) { i in
            
            NavigationLink(
              destination: HadithDetailsView(index: i, settings: settings),
              label: {
                HadithItem(settings: settings, index: i)
              }
            )
            .padding(.horizontal)
          }
        }
        .navigationBarItems(trailing: Button(action: {
          showSettings = true
        }, label: {
          Text("settings")
        }))
        .sheet(isPresented: $showSettings, content: {
          SettingsView(settings: settings)
        })
        .navigationBarTitle("nawawi_hadiths")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

struct CoverHadith: View {
  @ObservedObject var settings: Settings
  
  var body: some View {
    let coverFont = settings.isArabic() ? thuluthFont : englishDecoratedFont
    let coverFontSize = settings.isArabic() ? CGFloat(35) : CGFloat(20)
    
    Text("cover_hadith")
      .font(.custom(coverFont, size: coverFontSize))
      .lineSpacing(1)
      .multilineTextAlignment(.center)
      .foregroundColor(.secondary)
      .padding(30)
  }
}

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
        let hadithId = "hadith\(index)Id"
        let hadithSummary = "hadith\(index)Summary"
        
        Text(LocalizedStringKey(hadithId))
          .font(.custom(hadithIdFont, size: hadithIdFontSize, relativeTo: .footnote))
          .foregroundColor(.secondary)
        
        Text(LocalizedStringKey(hadithSummary))
          .font(.custom(hadithSummaryFont, size: 0.8 * CGFloat(settings.calcFontSize())))
          .foregroundColor(.primary)
      }
    }
    .contentShape(Rectangle())
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(5)
  }
}
