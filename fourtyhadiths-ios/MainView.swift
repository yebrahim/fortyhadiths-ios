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
        
        VStack {
          ForEach(1...42, id: \.self) { i in
            
            NavigationLink(
              destination: HadithDetailsView(index: i, settings: settings),
              label: {
                
                HStack {
                  Image(systemName: "\(i).square.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
                  
                  VStack (alignment: .leading) {
                    let hadithId = "hadith\(i)Id"
                    let hadithSummary = "hadith\(i)Summary"
                    
                    Text(LocalizedStringKey(hadithId))
                      .font(.custom(defaultFont, size: 13, relativeTo: .footnote))
                      .foregroundColor(.secondary)
                    
                    Text(LocalizedStringKey(hadithSummary))
                      .font(.custom(defaultFontBold, size: 0.8 * CGFloat(settings.calcFontSize())))
                      .foregroundColor(.primary)
                  }
                }
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                .padding(10)
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
