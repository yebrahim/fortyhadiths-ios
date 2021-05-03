import SwiftUI

struct SettingsView: View {
  @Environment(\.presentationMode)
  var presentationMode
  
  @ObservedObject
  var settings: Settings
  
  @State var font = ""
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("language")) {
          
          Picker("Language", selection: $settings.locale) {
            ForEach(settings.getLocales(), id: \.key) { key, value in
              Text(value)
            }
          }
          .onChange(of: settings.locale, perform: { value in
            UserDefaults.standard.set(value, forKey: Settings.languageStoreKey)
          })
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
            .onChange(of: settings.fontSize, perform: { value in
              UserDefaults.standard.set(value, forKey: Settings.fontSizeStoreKey)
            })
          }
          .padding()
          
          
          Picker("", selection: $font) {
                  ForEach(UIFont.familyNames, id: \.self) { family in
                    ForEach(UIFont.fontNames(forFamilyName: family), id: \.self) { fontName in
                      Text("\(fontName)")
                    }
                  }
                }
                .pickerStyle(WheelPickerStyle())

                Text(font)

                VStack(alignment: .center, spacing: 10) {
                  Text("Preview of the font")
                    .font(.custom("\(font)", size: 25))
                  Text("اللغة العربية")
                    .font(.custom("\(font)", size: 25))
                }
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
    .environment(\.layoutDirection, settings.isArabic() ? .rightToLeft : .leftToRight)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(settings: Settings())
  }
}
