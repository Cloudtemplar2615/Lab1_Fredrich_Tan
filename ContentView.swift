import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome to Prime Checker!")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)

    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
                .padding()
        }
    }
}
VStack {
    Text("\(number)")
        .font(.largeTitle)
        .padding()

    HStack {
        Button("Prime") {
            // Logic to be added later
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)

        Button("Not Prime") {
            // Logic to be added later
        }
        .padding()
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
