import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode)
  var presentationMode
  
  @ObservedObject
  var settings: Settings
  
  @State var selectedLocale = Settings.defaultLocale
  @State var selectedFontSize = Settings.defaultFontSize
  @State var hideDiacritics = false
  
  var body: some View {
    RtlNavigationView(settings: settings) {
      Form {
        Section(header: Text("language")) {
          
          Picker("Language", selection: $selectedLocale) {
            ForEach(settings.getLocales(), id: \.key) { key, value in
              Text(value)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()
          
          if settings.isArabic() {
            Toggle("hide_diacritics", isOn: $hideDiacritics)
          }
          
          HStack (spacing: 20) {
            Text("fontSize")
            
            Slider(
              value: $selectedFontSize,
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
      .onAppear() {
        selectedLocale = settings.locale
        selectedFontSize = settings.fontSize
        hideDiacritics = settings.hideDiacritics
      }
      .onDisappear() {
        settings.locale = selectedLocale
        settings.fontSize = selectedFontSize
        settings.hideDiacritics = hideDiacritics
        
        UserDefaults.standard.set(selectedLocale, forKey: Settings.languageStoreKey)
        UserDefaults.standard.set(selectedFontSize, forKey: Settings.fontSizeStoreKey)
        UserDefaults.standard.set(hideDiacritics, forKey: Settings.hideDiacriticsStoreKey)
      }
      .navigationBarTitle("settings")
      .navigationBarItems(trailing: Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Text("apply")
      }))
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(settings: Settings())
  }
}
