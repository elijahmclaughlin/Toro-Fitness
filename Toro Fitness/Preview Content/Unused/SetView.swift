//
//  SetView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//

//import SwiftUI
//
//struct SetView: View {
//    @State private var set: StoreUserSetData
//
//    init(set: StoreUserSetData) {
//        self._set = State(initialValue: set)
//    }
//
//    var body: some View {
//        HStack {
//            Text("Set \(set.setNumber)")
//            Spacer()
//            TextField("Weight", text: Binding(
//                get: { String(set.setWeight) },
//                set: { set.setWeight = Int16($0) ?? 0 }
//            ))
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .frame(width: 50)
//            TextField("Reps", text: Binding(
//                get: { String(set.setReps) },
//                set: { set.setReps = Int16($0) ?? 0 }
//            ))
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .frame(width: 50)
//        }
//        .padding()
//    }
//}
//
//struct SetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetView(set: StoreUserSetData())
//            .environmentObject(WorkoutManager(context: PersistenceController.shared.container.viewContext))
//    }
//}
