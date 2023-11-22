//
//  ActAPIApp.swift
//  ActAPI
//
//  Created by Fernanda.M Guzman on 19/11/23.
//

import SwiftUI

@main
struct ActAPIApp: App {
    var sharedViewModel = DogViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(sharedViewModel)
        }
    }
}
