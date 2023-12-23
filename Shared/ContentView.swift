//
//  ContentView.swift
//  Shared
//
//  Created by Randy Horman on 2023-12-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Popper.getPopping, ascending: true)],
        animation: .default)
    private var pops: FetchedResults<Popper>

    var body: some View {
        NavigationView {
            List {
                ForEach(pops) { pop in
                    NavigationLink {
                        Text("Pop at \(pop.getPopping!, formatter: popFormatter)")
                    } label: {
                        Text(pop.getPopping!, formatter: popFormatter)
                    }
                }
                .onDelete(perform: deletePop)
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addPop) {
                        Label("Add Pop", systemImage: "plus")
                    }
                }
            }
            Text("Select an pop")
        }
    }

    private func addPop() {
        withAnimation {
            let newPop = Popper(context: viewContext)
            newPop.getPopping = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deletePop(offsets: IndexSet) {
        withAnimation {
            offsets.map { pops[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let popFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
        }
    }
}
