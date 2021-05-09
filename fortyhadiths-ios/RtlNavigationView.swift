import SwiftUI

// NavigationView that responds to settings.locale and settings.isArabic changes
// by reloading itself to re-initialize nav bar appearance attributes.
struct RtlNavigationView<Content>: View where Content: View {
  
  @ObservedObject
  var settings: Settings
  
  var content: Content
  
  init(settings: Settings, content: () -> Content) {
    self.settings = settings
    self.content = content()
    
    UINavigationBar.appearance().largeTitleTextAttributes = [
      .font: UIFont(name: settings.isArabic() ? thuluthFont : englishFont, size: settings.isArabic() ? 55 : 40)!,
    ]
  }
  
  var body: some View {
    NavigationView {
      content
    }
    .id(settings.isArabic())
    .environment(\.locale, .init(identifier: settings.locale))
    .environment(\.layoutDirection, settings.isArabic() ? .rightToLeft : .leftToRight)
  }
}
