//
//  ContentView.swift
//  todo-vision
//
//  Created by diego on 23/06/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var newTodo: String = ""
    @State private var todos: [String] = []

    @State var showImmersiveSpace = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(todos, id: \.self) { todo in
                    Text(todo)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Todo List")
        } detail: {
            VStack {
                TextField("New task", text: $newTodo)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button(action: {
                    if newTodo != "" {
                        todos.append(newTodo)
                        newTodo = ""
                    }
                }) {
                    Text("Add Task")
                }

                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)

                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
            }
            .navigationTitle("Content")
            .padding()
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
