import SwiftUI

struct ContentView: View {
  
  var hadiths: [HadithData] = Hadiths.data
  
  @ObservedObject
  var settings = Settings()
  
  @State var showSettings = false
  
  var body: some View {
    
    NavigationView {
      
      VStack (alignment: .leading) {
        
        List(hadiths.enumerated().map({ $0 }), id: \.element.id) { i, hadith in
          
          NavigationLink(
            destination: HadithDetailsView(hadith: hadith, settings: settings),
            label: {
              
              Image(systemName: "\(i + 1).square.fill")
                .resizable()
                .foregroundColor(.gray)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.trailing)
              
              VStack (alignment: .leading) {
                Text(hadith.id)
                  .font(.footnote)
                  .foregroundColor(.secondary)
                
                Text(hadith.summary)
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
    ContentView()
  }
}
