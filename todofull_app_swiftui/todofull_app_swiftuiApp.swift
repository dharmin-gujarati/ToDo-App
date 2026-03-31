//
//  todofull_app_swiftuiApp.swift
//  todofull_app_swiftui
//
//  Created by CDMI on 19/02/26.
//

import SwiftUI

@main
struct todofull_app_swiftuiApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    let persistenceController = PersistenceController.shared
       
       var body: some Scene {
           WindowGroup {
               ContentView()
                   .preferredColorScheme(isDarkMode ? .dark : .light)
                   .environment(\.managedObjectContext,
                                                 persistenceController.container.viewContext)
           }
//           WindowGroup {
//               ContentView()
//                   .environment(\.managedObjectContext,
//                                                 persistenceController.container.viewContext)
//           }
       }
   }
