//
//  hello_visionApp.swift
//  hello-vision
//
//  Created by diego on 23/06/2023.
//

import SwiftUI

@main
struct hello_visionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
