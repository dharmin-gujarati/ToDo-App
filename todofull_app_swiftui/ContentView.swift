

import SwiftUI

struct ContentView: View {
    @State private var Signup = false
    @AppStorage("isDarkMode") var isDarkMode = false
    var body: some View {
       
        NavigationStack
        {
            VStack
            {
                ProgressView("Please Wait")
            }
            .navigationDestination(isPresented: $Signup){
                            if(UserDefaults.standard.bool(forKey: "isLogin"))
                            {
                                todofull_home()
                            }else{
                                todofull_login()
                            }
                        }
            .onAppear
            {
                DispatchQueue.main.asyncAfter(deadline: .now()+2)
                {
                    Signup = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

