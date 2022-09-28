//
//  AppstrorageBootcamp.swift
//  AppStorageBootcamp
//
//  Created by Bishowjit Ray on 25/9/22.
//

import SwiftUI

struct AppstrorageBootcamp: View {
    
    @State var currentUserName: String?
    
    var body: some View {
        VStack(spacing:20){
            Text(currentUserName ?? "Add name here")
            if let name = currentUserName {
                Text(name)
            }
            
            Button("Save".uppercased()){
              currentUserName = "Nick"
            }
        }
    }
}

struct AppstrorageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AppstrorageBootcamp()
    }
}
