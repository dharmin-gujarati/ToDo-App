//
//  todofull_signup.swift
//  todofull_app_swiftui
//
//  Created by CDMI on 19/02/26.
//

import SwiftUI

struct todofull_signup: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var cpassword = ""
    @State private var policy = false
    @State private var showPassword = false
    @State private var showPassword2 = false
    @State private var goNext = false
    @State private var showAlert = false
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Circle()
                        .fill(Color(red: 0.145, green: 0.388, blue: 0.922))
                        .frame(width: 70)
                        .overlay {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 30.0, height: 30.0)
                                .colorInvert()
                        }
                    
                    Text("ToDo")
                        .bold()
                        .font(.title)
                        .foregroundStyle(Color(red: 0.145, green: 0.388, blue: 0.922))
                }
                .padding(.bottom, 50)
                VStack(spacing : 20){
                    TextField("Full Name", text: $fullname)
                        .bold()
                        .font(.system(size: 20))
                        .padding([.top, .bottom, .trailing], 50)
                        .padding(.leading, 15)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.914))
                        .frame(width: 395,height: 50)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("Email Address", text: $email)
                    
                        .bold()
                        .font(.system(size: 20))
                        .padding([.top, .bottom, .trailing], 50)
                        .padding(.leading, 15)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.914))
                        .frame(width: 395,height: 50)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    
                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    HStack {
                        if showPassword2 {
                            TextField("Conform Password", text: $cpassword)
                        } else {
                            SecureField("Conform Password", text: $cpassword)
                        }
                        
                        Button {
                            showPassword2.toggle()
                        } label: {
                            Image(systemName: showPassword2 ? "eye" : "eye.slash")
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    
                }
                HStack{
                    Button {
                        policy.toggle()
                    } label: {
                        Image(systemName: policy ? "checkmark.square.fill" : "checkmark.square")
                    }
                    Text("I have read,understood & agreed  ToDo's")
                        .foregroundColor(Color(red: 0.561, green: 0.588, blue: 0.627))
                        .font(.system(size: 15))
                }
                .padding(.top, 40)
                Button("Privacy policy , Terms & condition") {}
                    .padding(.bottom, 40)
                    .font(.system(size: 15))
                
                NavigationLink( destination: todofull_login(), isActive: $goNext){
                    
                    Button(action: {
                        signup()
                    }) {
                        Text("Sign Up")
                    }
                    .frame(width: 390 , height: 70)
                    .background(Color(red: 0.145, green: 0.388, blue: 0.922))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .font(.largeTitle)
                    
                }
                
                
                .padding(.top, 15)
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(Color(red: 0.561, green: 0.588, blue: 0.627))
                        .font(.system(size: 15))
                    Button("Login") {
                        goNext = true
                    }
                    .font(.system(size: 15))
                }
                .padding(.top, 50.0)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    func signup()
    {
        if(!policy) {
            return
        }
        if(fullname.isEmpty) {
            return
        }
        if(email.isEmpty) {
            return
        }
        if(password.isEmpty){
            return
        }
        if(password != cpassword){
            return
        }
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(fullname, forKey: "name")
        goNext = true
    }
}

#Preview {
    todofull_signup()
}
