
import SwiftUI
import AVKit

struct ExerciseView: View {
    var exercise: Exercise {
        Exercise.exercises[index]
    }
    @State private var showSuccess = false
    @State private var showHistory = false
    @State private var timerDone = false
    @State private var showTimer = false
    @Binding var selectedTab: Int
    @EnvironmentObject var history: HistoryStore
    var startButton: some View {
        Button("Start Exercise") {
          showTimer.toggle()
        }
    }
    var doneButton: some View {
      Button("Done") {
          history.addDoneExercise(Exercise.exercises[index].exerciseName)
          timerDone = false
          showTimer.toggle()
          if lastExercise {
              showSuccess.toggle()
          } else {
              selectedTab += 1
          }
      }
    }
    var lastExercise: Bool {
      index + 1 == Exercise.exercises.count
    }
    let index: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(
                  selectedTab: $selectedTab,
                  titleText: Exercise.exercises[index].exerciseName)
                    .padding(.vertical)
                
                VideoPlayerView(videoName: exercise.videoName)
                  .frame(height: geometry.size.height * 0.45)
                
                HStack(spacing: 150) {
                  startButton
                  doneButton
                        .disabled(!timerDone)
                        .sheet(isPresented: $showSuccess) {
                            SuccessView(selectedTab: $selectedTab)
                              .presentationDetents([.medium, .large])
                        } }
                        .font(.title3)
                        .padding()
                        if showTimer {
                          TimerView(
                            timerDone: $timerDone,
                            size: geometry.size.height * 0.07
                          )
                        }
                        Spacer()
                RatingView(exerciseIndex: index)
                        .padding()
                Button("History") {
                  showHistory.toggle()
                }.sheet(isPresented: $showHistory) {
                  HistoryView(showHistory: $showHistory)
                }
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ExerciseView(selectedTab: .constant(0), index: 0)
      .environmentObject(HistoryStore())
}

