
import SwiftUI

struct HeaderView: View {
    
    @Binding var selectedTab: Int  // 1
    let titleText: String
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
            HStack { // 2
                ForEach(Exercise.exercises.indices, id: \.self) { index in //3
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "\(index + 1).circle\(fill)").onTapGesture {
                        selectedTab = index
                      }  // 4
                }
            }
            .font(.title2)
        }
    }
}



#Preview {
    HeaderView(selectedTab: .constant(0), titleText: "Squat")
      .previewLayout(.sizeThatFits)
}
