import SwiftUI
import StoreKit

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

      VStack {
        Form {
          Section(header: Text("language")) {

            Picker("Language", selection: $selectedLocale) {
              ForEach(settings.getLocales(), id: \.key) { key, value in
                Text(value)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

          }

          if settings.isArabic() {
            Section(header: Text("diacritics")) {
              Toggle("hide_diacritics", isOn: $hideDiacritics)
            }
          }

          Section(header: Text("fontSize")) {

            HStack (spacing: 20) {
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

          Button("rate_us") {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
              SKStoreReviewController.requestReview(in: windowScene)
            }
          }
          .foregroundColor(.primary)

          Button("share_app") {
            guard let url = URL(string: "https://apps.apple.com/us/app/40-hadiths-%D8%A7%D9%84%D8%A3%D8%B1%D8%A8%D8%B9%D9%88%D9%86/id1564885579") else {
              return
            }
            
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityVC.modalPresentationStyle = .pageSheet
            UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.present(activityVC, animated: true, completion: nil)
          }
          .foregroundColor(.primary)
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

        Text("Connect with us at fortyhadiths@gmail.com")
          .foregroundColor(.secondary)
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()

        Text("40 Hadiths - Version \(versionString())")
          .foregroundColor(.secondary)
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
  }

  func versionString() -> String {
    let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return "\(versionNumber ?? "")"
  }

}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(settings: Settings())
  }
}
