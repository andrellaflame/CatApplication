//
//  CatList.swift
//  CatApplication
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import SwiftUI
import Networking
import FirebaseCrashlytics

struct CatList: View {
    @EnvironmentObject var viewModel: CatStorage
    
    var body: some View {
        NavigationView {
            ScrollView {
                Button {
                    Crashlytics.crashlytics().log("Crash log")
                    fatalError("Crashed on list page")
                } label: {
                    Text("Crash")
                        .frame(maxWidth: .infinity)
                }
                .padding([.horizontal], 8)
                .buttonStyle(.bordered)
                .tint(.pink)

                LazyVStack {
                    ForEach($viewModel.catsList) { $element in
                        let name = viewModel.getRandomName()
                        NavigationLink {
                            CatListDetails(catImage: element.url ?? "", catName: name)
                        } label: {
                            CatListCell(catImage: element.url ?? "", catName: name)
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("\(viewModel.isCatApiUsed() ? "Cats": "Dogs")")
            .listStyle(PlainListStyle())
        }
    }
}

struct CatList_Previews: PreviewProvider {
    static var previews: some View {
        CatList().environmentObject(
            CatStorage()
        )
    }
}
