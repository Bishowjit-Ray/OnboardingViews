//
//  IntroView.swift
//  AppStorageBootcamp
//
//  Created by Bishowjit Ray on 27/9/22.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [Color.green, Color.red]),
                center: .topLeading,
                startRadius: 5,
                           endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            // if user is signed in
            // profile view
            // else
            // onboarding view
            
            if currentUserSignedIn {
              ProfileView()
                
            }
            else {
                OnboardingView()
            }
            
            
         
            
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
