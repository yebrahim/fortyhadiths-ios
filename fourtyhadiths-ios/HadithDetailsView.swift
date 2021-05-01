//
//  HadithDetailsView.swift
//  fourtyhadiths-ios
//
//  Created by Yasser Elsayed on 4/30/21.
//

import SwiftUI

struct HadithDetailsView: View {
    
    var hadith: HadithData
    
    var body: some View {
        ScrollView {
            
            Text(hadith.body)
                .navigationTitle(hadith.id)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding()
        }
    }
}

struct HadithDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HadithDetailsView(hadith: Hadiths.data.first!)
    }
}
