import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode)
  var presentationMode
  
  @ObservedObject
  var settings: Settings
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("language")) {
          
          Picker("Language", selection: $settings.locale) {
            ForEach(settings.locales.sorted(by: >), id: \.key) { key, value in
              Text(value)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          .padding()
          
          HStack (spacing: 20) {
            Text("fontSize")
            
            Slider(
              value: $settings.fontSize,
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
      .navigationBarItems(trailing: Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Text("Dismiss")
      }))
    }
    .environment(\.locale, .init(identifier: settings.locale))
    .environment(\.layoutDirection, settings.locale == "ar" ? .rightToLeft : .leftToRight)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(settings: Settings())
  }
}
