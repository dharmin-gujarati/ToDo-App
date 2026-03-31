//
//  todofull_login.swift
//  todofull_app_swiftui
//
//  Created by CDMI on 19/02/26.
//

import SwiftUI


struct todofull_login: View {
    var Email = ""
    var Password = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var goNext = false
    @State private var gotohome = false
    
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
                    
                    
                }
                Button(action: {
                    login()
                }) {
                    Text("Log in")
                }
                .frame(width: 390 , height: 70)
                .background(Color(red: 0.145, green: 0.388, blue: 0.922))
                .foregroundColor(.white)
                .cornerRadius(15)
                .font(.largeTitle)
                .padding(.top, 40.0)
                
                
                
                HStack{
                    Button("Forgot password?") {}
                        .font(.system(size: 15))
                    Spacer()
                    Text("Don't have an account?")
                        .foregroundColor(Color(red: 0.561, green: 0.588, blue: 0.627))
                        .font(.system(size: 15))
                    Button("Sine Up") {
                        goNext = true
                    }
                    .font(.system(size: 15))
                    NavigationLink("", destination: todofull_home(), isActive: $gotohome)
                        .hidden()
                    NavigationLink("", destination: todofull_signup(), isActive: $goNext)
                        .hidden()
                }
                .padding(.top, 50.0)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    func login()
    {
        if(email.isEmpty)
        {
            return
        }
        if(password.isEmpty)
        {
            return
        }
        let mainEmail = UserDefaults.standard.string(forKey: "email")
        let mainPassword = UserDefaults.standard.string(forKey: "password")
                if(mainEmail == email && mainPassword == password){
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    gotohome = true
                }
        
    }
}
#Preview {
    todofull_login(Email: "asd" , Password: "12" )
}
