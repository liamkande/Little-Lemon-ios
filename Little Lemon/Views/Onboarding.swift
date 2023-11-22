//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

let kFirstName = "First Name"
let kLastName = "Last Name"
let kEmail = "Email"
let kIsLoggedIn = "kIsLoggedIn"

let kOrderStatus = "Order Status"
let kPasswordChanges = "Password Changes"
let kSpecialOffers = "Special Offers"
let kNewsletter = "Newsletter"

let kProfileImage = "Profile Image"

let kNavigationStyle = "Navigation Style"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Hero(searchText: .constant(""), includeTextField: false) // TODO: Add a convinience init()
                    .frame(maxHeight: 300)

                Form{
                    FormFieldItem(Section: "First Name", TextValue: $firstName)
                    FormFieldItem(Section: "Last Name", TextValue: $lastName)
                    FormFieldItem(Section: "Email", TextValue: $email)
                }
                .formStyle(.columns)
                .padding()
                
                Button("Register") {
                    // TODO: Add email validation (inline?)
                    if (!firstName.isEmpty &&
                        !lastName.isEmpty &&
                        !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set("profile-image-placeholder", forKey: kProfileImage)
                        UserDefaults.standard.set(false, forKey: kOrderStatus)
                        UserDefaults.standard.set(false, forKey: kPasswordChanges)
                        UserDefaults.standard.set(false, forKey: kSpecialOffers)
                        UserDefaults.standard.set(false, forKey: kNewsletter)
                        UserDefaults.standard.set(true, forKey: kNavigationStyle)
                        
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .font(.LLLead)
                .padding()
                
            }
            .onAppear{
                if (UserDefaults.standard.bool(forKey: kIsLoggedIn)){
                    isLoggedIn = true
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    NavigationLogo()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Onboarding()
}
