//
//  CatListDetails.swift
//  CatApplication
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics
import FirebasePerformance

struct CatListDetails: View {
    let catImage: String
    let catName: String
    
    var body: some View {
        VStack {
            Button {
                Crashlytics.crashlytics().log("Crash log")
                fatalError("Crashed on details page")
            } label: {
                Text("Crash")
                    .frame(maxWidth: .infinity)
            }
            .padding([.horizontal, .top], 8)
            .buttonStyle(.bordered)
            .tint(.pink)
            
            Text("\(catName)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .font(.title)
            
            AsyncImage(url: URL(string: catImage)) { cat in
                cat.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        Crashlytics.crashlytics().log("User tapped on: \(catImage)")
                    }
            }
            
            Spacer()
        }
    }
}

struct CatListDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatListDetails(catImage: CatDTO.testCat.url ?? "", catName: "Nameless cat")
    }
}
