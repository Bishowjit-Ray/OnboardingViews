//
//  OnboardingView.swift
//  AppStorageBootcamp
//
//  Created by Bishowjit Ray on 27/9/22.
//

import SwiftUI


struct OnboardingView: View {
    // Onboarding states:
    /*
     0- Welcome screen
     1- add name
     2- add age
     3- add gender
     */
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    // onboarding inputs
    
    @State var name: String = ""
    @State var age: Double = 50
    @State var gender: String = ""
    
    // for the alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //app storage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currrentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    var body: some View {
     
        ZStack{
            // content
            ZStack{
                switch onboardingState{
                case 0:
                    welcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.green)
                }
            }
            // button
            
            VStack{
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        
        .alert(isPresented: $showAlert, content: {
            return Alert (title: Text(alertTitle))
        })
    }
    

}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
          
            .background(Color.purple)
    }
}
// MARK: Components

extension OnboardingView {
    
    private var bottomButton: some View{
        Text(onboardingState == 0 ? "Sign up" :
                onboardingState == 3 ? "FINISH" :
                "Next "
        )
        
            .font(.headline)
            .foregroundColor(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
             .animation(nil)
            .onTapGesture {
                handleNextButtonPressed()
            }
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
          Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold )
                .foregroundColor(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundColor(.white)
                    ,alignment: .bottomTrailing
                )
      
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }

    private var addNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
  
            Text("What's your name?.")
                .font(.largeTitle)
                .fontWeight(.semibold )
                .foregroundColor(.white)
           
            TextField("Your name here...", text: $name)
                .font(.headline)
                .frame(height: 55)
                .foregroundColor(.black)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
            Spacer()
            Spacer()
        }
       
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 40) {
            Spacer()
  
            Text("What's your Age?.")
                .font(.largeTitle)
                .fontWeight(.semibold )
                .foregroundColor(.white)
        
            Text("\(String(format: "%.0f", age))")
            Slider(value: $age, in: 18...100, step: 1)
                .accentColor(.white)
            Spacer()
            Spacer()
        }
       
        .padding(30)
    }
    private var addGenderSection: some View {
        VStack(spacing: 40) {
            Spacer()
  
            Text("What's your Gender?.")
                .font(.largeTitle)
                .fontWeight(.semibold )
                .foregroundColor(.white)
        
            Picker(selection: $gender,
                 label:
                    Text(gender.count > 1 ? gender:"Select a gender")
                .font(.headline)
                .foregroundColor(.purple)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10),

                   content: {
                      
                    
                       Text("Male").tag("Male")
                       Text("Female").tag("Female")
                       Text("Non-Binary").tag("Non-Binary")
                   })
           
            Spacer()
            Spacer()
        }
       
        .padding(30)
    }
}
// MARK: FUNCTION

 extension OnboardingView {
     
    func handleNextButtonPressed() {
        // Check Inputs
        
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: " Your name must be at least 3 characters long! ")
            
                
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender before moving forward!!!")
                return
            }
        default:
            break
        }
        
        // Go TO Next Section
        if onboardingState == 3 {
            // Sign in
            signIn()
        }
        else{
            withAnimation (.spring()){
                onboardingState += 1
            }
        }
       
    }
     func signIn() {
         currentUserName = name
         currentUserAge = Int(age)
         currrentUserGender = gender
         withAnimation {
             currentUserSignedIn = true
         }
     }
     
     func showAlert(title: String){
         alertTitle
          = title
         showAlert.toggle()
     }
}
