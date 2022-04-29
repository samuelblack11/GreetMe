//
//  CollageStyleCollectionVC.swift
//  GreetMe
//
//  Created by Sam Black on 4/27/22.
//

import Foundation
import SwiftUI

class CollageStyleCollectionVC: UICollectionViewController {

struct ContentView: View {
    
    let data = (1...100).map { "Item \($0)"}
    let columns = [ GridItem(.adaptive(minimum: 80))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 300)
    }

    }

}
