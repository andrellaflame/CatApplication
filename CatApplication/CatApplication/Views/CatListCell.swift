//
//  CatListCell.swift
//  CatApplication
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import SwiftUI
import Networking
import FirebasePerformance

struct CatListCell: View {
    let catImage: String
    let catName: String
    let imageTrace = Performance().trace(name: "AsyncImageLoad")
    
    var body: some View {
        HStack (alignment: .top, spacing: 16) {
        
            AsyncImage(url: URL(string: catImage)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .failure(let error):
                    Text("Error occured: \(error.localizedDescription)")
                        .onAppear() {
                            imageTrace?.stop()
                        }
                case .success(let cat):
                    cat.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(10)
                        .padding(8)
                        .onAppear() {
                            imageTrace?.stop()
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .onAppear() {
                imageTrace?.start()
            }
            
            Text(catName)
                .padding(8)
                .fontWeight(.semibold)
                .background(
                    Color(.gray),
                    in: RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                )
                .padding([.top], 8)
            Spacer()
        }
        .frame(height: 150)
        .background(
            Color(.lightGray),
            in: RoundedRectangle(cornerRadius: 15.0, style: .continuous)
        )
        .padding(4)
        
    }
}

struct CatListCell_Previews: PreviewProvider {
    static var previews: some View {
        CatListCell(catImage: CatDTO.testCat.url ?? "", catName: "Nameless cat")
    }
}
