import SwiftUI

struct MainView: View {
  
  @ObservedObject
  var settings = Settings()
  
  @State var showSettings = false
  @State var pressed = false
  
  let defaultFont = "AlNile"
  let defaultFontBold = "AlNile-Bold"
  let headerFont = "AlNile-Bold"
  
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .font: UIFont(name: headerFont, size: 40)!
    ]
  }
  
  var body: some View {
    
    NavigationView {
      ScrollView(showsIndicators: false) {
        
        CoverHadith(settings: settings)
        
        Divider().frame(width: 50).padding()
        
        VStack {
          ForEach(1...42, id: \.self) { i in
            
            NavigationLink(
              destination: HadithDetailsView(index: i, settings: settings),
              label: {
                
                HStack {
                  Image(systemName: "\(i).square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                  
                  VStack (alignment: .leading) {
                    let hadithId = "hadith\(i)Id"
                    let hadithSummary = "hadith\(i)Summary"
                    
                    Text(LocalizedStringKey(hadithId))
                      .font(.custom(defaultFont, size: 13, relativeTo: .footnote))
                      .foregroundColor(.secondary)
                    
                    Text(LocalizedStringKey(hadithSummary))
                      .font(.custom(defaultFontBold, size: 0.9 * CGFloat(settings.calcFontSize())))
                      .foregroundColor(.primary)
                    Divider()
                  }
                  
                }
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .contentShape(Rectangle())
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
    .environment(\.locale, .init(identifier: settings.locale))
    .environment(\.layoutDirection, settings.isArabic() ? .rightToLeft : .leftToRight)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

struct CoverHadith: View {
  let settings: Settings
  
  var body: some View {
    let coverFont = settings.isArabic() ? "DiwanMishafi" : "Georgia-Italic"
    let coverFontSize = settings.isArabic() ? CGFloat(35) : CGFloat(20)
    
    Text("cover_hadith")
      .font(.custom(coverFont, size: coverFontSize))
      .lineSpacing(3)
      .multilineTextAlignment(.center)
      .foregroundColor(.secondary)
      .padding(30)
  }
}
