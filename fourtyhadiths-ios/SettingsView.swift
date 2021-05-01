import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode)
  var presentationMode
  
  @ObservedObject
  var settings: Settings
  
  @State
  var locale = Settings.defaultLocale
  
  @State
  var fontSize = Settings.defaultFontSize
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("language")) {
          
          Picker("Language", selection: $locale) {
            ForEach(settings.locales.sorted(by: >), id: \.key) { key, value in
              Text(value)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()
          
          HStack (spacing: 20) {
            Text("fontSize")
            
            Slider(
              value: $fontSize,
              in: settings.minFontSize...settings.maxFontSize,
              step: 5,
              minimumValueLabel: Text("A").font(.system(.subheadline)),
              maximumValueLabel: Text("A").font(.system(.largeTitle))
            ) {
              Text("Speed")
            }
          }
          .padding()
        }
      }
      .navigationBarTitle("settings")
      .onAppear(perform: {
        locale = settings.locale
        fontSize = settings.fontSize
      })
      .navigationBarItems(trailing: Button(action: {
        settings.fontSize = fontSize
        settings.locale = locale
        
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Text("Dismiss")
      }))
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(settings: Settings())
  }
}
