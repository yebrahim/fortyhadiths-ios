import SwiftUI

struct ContentView: View {
  
  var hadiths: [HadithData] = Hadiths.data
  @State var locale = "en"
  
  var body: some View {
    
    NavigationView {
      
      VStack (alignment: .leading) {
        
        List(hadiths.enumerated().map({ $0 }), id: \.element.id) { i, hadith in
          
          NavigationLink(
            destination: HadithDetailsView(hadith: hadith),
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
              }
            }
          )
        }
      }
      .navigationTitle("nawawi_hadiths")
    }
    .environment(\.locale, .init(identifier: locale))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
