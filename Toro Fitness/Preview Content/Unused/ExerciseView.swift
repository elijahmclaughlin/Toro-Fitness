//
//  ExerciseView.swift
//  Toro Fitness
//
//  Created by Elijah McLaughlin on 6/25/24.
//

//import SwiftUI
//
//struct ExerciseView: View {
//    @State private var exercise: StoreUserExerciseData
//
//    init(exercise: StoreUserExerciseData) {
//        self._exercise = State(initialValue: exercise)
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(exercise.exerciseTitle ?? "Exercise")
//                .font(.headline)
//                .padding(.top)
//            
//            ForEach(exercise.relationshipSet?.allObjects as? [StoreUserSetData] ?? [], id: \.self) { set in
//                SetView(set: set)
//            }
//            .onDelete(perform: deleteSet)
//            
//            Button(action: addSet) {
//                Text("Add Set")
//            }
//        }
//        .padding()
//        .background(Color(UIColor.systemGray6))
//        .cornerRadius(10)
//        .padding(.horizontal)
//    }
//
//    private func addSet() {
//        let newSet = StoreUserSetData(context: exercise.managedObjectContext!)
//        newSet.setID = UUID()
//        newSet.setNumber = Int16(exercise.relationshipSet?.count ?? 0 + 1)
//        newSet.relationshipExercise = exercise
//        exercise.addToRelationshipSet(newSet)
//        try? exercise.managedObjectContext?.save()
//    }
//
//    private func deleteSet(at offsets: IndexSet) {
//        if let sets = exercise.relationshipSet?.allObjects as? [StoreUserSetData] {
//            for index in offsets {
//                let set = sets[index]
//                exercise.managedObjectContext?.delete(set)
//            }
//            try? exercise.managedObjectContext?.save()
//        }
//    }
//}
//
//struct ExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseView(exercise: StoreUserExerciseData())
//    }
//}
