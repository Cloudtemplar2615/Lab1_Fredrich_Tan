import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var isCorrect: Bool? = nil
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var timer: Timer?
    @State private var attempts: Int = 0
    @State private var showDialog: Bool = false


    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
                .padding()

            HStack {
                Button("Prime") {
                    self.checkAnswer(isPrime: true)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Not Prime") {
                    self.checkAnswer(isPrime: false)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            // Show Result (Checkmark or Cross)
            if let correct = isCorrect {
                Image(systemName: correct ? "checkmark.circle" : "xmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(correct ? .green : .red)
            }
        }
    }

    // Function to Check if the Number is Prime
    func isPrimeNumber(_ n: Int) -> Bool {
        if n <= 1 { return false }
        if n == 2 { return true }
        for i in 2..<Int(sqrt(Double(n))) + 1 {
            if n % i == 0 { return false }
        }
        return true
    }

    // Function to Check User's Answer
    func checkAnswer(isPrime: Bool) {
        if isPrime == isPrimeNumber(number) {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
        isCorrect = (isPrime == isPrimeNumber(number))
    }
}
    func startTimer() {
    timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
        self.wrongAnswers += 1
        self.isCorrect = false
    }
}

.onAppear(perform: startTimer)

    func checkAnswer(isPrime: Bool) {
    if isPrime == isPrimeNumber(number) {
        correctAnswers += 1
    } else {
        wrongAnswers += 1
    }
    attempts += 1
    if attempts >= 10 {
        showDialog = true
    }
    isCorrect = (isPrime == isPrimeNumber(number))
}

.alert(isPresented: $showDialog) {
    Alert(title: Text("Results"), message: Text("Correct: \(correctAnswers), Wrong: \(wrongAnswers)"), dismissButton: .default(Text("OK")))
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

