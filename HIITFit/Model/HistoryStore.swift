

import Foundation

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercises: [String] = []
}

class HistoryStore: ObservableObject {
  @Published var exerciseDays: [ExerciseDay] = []
  
    enum FileError: Error {
        case loadFailure
        case saveFailure
    }

  init() {
    #if DEBUG
    //createDevData()
    #endif
    print("Initializing HistoryStore")
    
    do {
        try load()
    } catch {
        print("Error:", error)
    }
      
  }
  
    func load() throws {
        throw FileError.loadFailure
    }
  
  func addDoneExercise(_ exerciseName: String) {
    let today = Date()
      if let firstDate = exerciseDays.first?.date,
        today.isSameDay(as: firstDate) { // 1
      print("Adding \(exerciseName)")
      exerciseDays[0].exercises.append(exerciseName)
    } else {
      exerciseDays.insert( // 2
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
    }
    print("History: ", exerciseDays)
  }
}



