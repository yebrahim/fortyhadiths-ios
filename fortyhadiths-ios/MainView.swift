import SwiftUI

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
