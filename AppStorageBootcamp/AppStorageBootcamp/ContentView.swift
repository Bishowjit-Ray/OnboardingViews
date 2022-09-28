//
//  ContentView.swift
//  AppStorageBootcamp
//
//  Created by Bishowjit Ray on 25/9/22.
//

import SwiftUI

struct ContentView: View {
    //@State var currentUserName: String?
    @AppStorage("name") var currentUserName: String?
    var body: some View {
        VStack(spacing:20){
            Text(currentUserName ?? "Add name here")
            if let name = currentUserName {
                Text(name)
                
            } 
            
            Button("Save".uppercased()){
                let name: String = "Nick"
              currentUserName = name
//                UserDefaults.standard.set(name, forKey: "name")
            }
        }
//        .onAppear{
//            currentUserName = UserDefaults.standard.string(forKey: "name")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
