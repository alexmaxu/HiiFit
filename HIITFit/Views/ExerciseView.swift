
import SwiftUI
import AVKit

struct ExerciseView: View {
    var exercise: Exercise {
        Exercise.exercises[index]
    }
    @State private var showHistory = false
    @State private var rating = 0
    @Binding var selectedTab: Int
    var startButton: some View {
      Button("Start Exercise") { }
    }
    var doneButton: some View {
      Button("Done") {
        selectedTab = lastExercise ? 9 : selectedTab + 1
      }
    }
    var lastExercise: Bool {
      index + 1 == Exercise.exercises.count
    }
    let index: Int
    let interval: TimeInterval = 30
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(
                  selectedTab: $selectedTab,
                  titleText: Exercise.exercises[index].exerciseName)
                    .padding(.vertical)
                
                VideoPlayerView(videoName: exercise.videoName)
                  .frame(height: geometry.size.height * 0.45)
                
                Text(Date().addingTimeInterval(interval), style: .timer).font(.system(size: geometry.size.height * 0.07))
                HStack(spacing: 150) {
                  startButton
                  doneButton }
                    .font(.title3)
                    .padding()
                RatingView(rating: $rating)
                Spacer()
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
    ExerciseView(selectedTab: .constant(1), index: 1)
}

