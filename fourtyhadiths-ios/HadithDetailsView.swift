//
//  HadithDetailsView.swift
//  fourtyhadiths-ios
//
//  Created by Yasser Elsayed on 4/30/21.
//

import SwiftUI

struct HadithDetailsView: View {
  
  var hadith: HadithData
  var settings: Settings
  
  var body: some View {
    ScrollView {
      
      Text(hadith.body)
        .navigationTitle(hadith.id)
        .multilineTextAlignment(.leading)
        .padding()
        .font(.system(size: CGFloat(settings.fontSize)))
    }
  }
}

struct HadithDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    HadithDetailsView(hadith: Hadiths.data.first!, settings: Settings())
  }
}
