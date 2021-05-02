import SwiftUI

struct MainView: View {
  
  @ObservedObject
  var settings = Settings()
  
  @State var showSettings = false
  
  var body: some View {
    
    NavigationView {
      
      VStack (alignment: .leading) {
        ForEach(1...10, id: \.self) { i in
          
          NavigationLink(
            destination: HadithDetailsView(index: i, settings: settings),
            label: {
              
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
                  .font(.footnote)
                  .foregroundColor(.secondary)
                
                Text(LocalizedStringKey(hadithSummary))
                  .fontWeight(.semibold)
                  .font(.system(size: CGFloat(settings.fontSize)))
              }
            }
          )
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
      .navigationTitle("nawawi_hadiths")
    }
    .environment(\.locale, .init(identifier: settings.locale))
    .environment(\.layoutDirection, settings.locale == "ar" ? .rightToLeft : .leftToRight)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
