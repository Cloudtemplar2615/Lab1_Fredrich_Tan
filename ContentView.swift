import SwiftUI
import UIKit
// state variable to hold the random number
struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...1000)
    @State private var isCorrect: Bool? = nil
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var attempts: Int = 0
    @State private var showDialog: Bool = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text("Prime Number Checker")
                .font(.title)
                .bold()
                .padding(.bottom, 10)

            Text("\(number)")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding()

            HStack {
                Button("Prime") {
                    self.checkAnswer(isPrime: true)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)

                Button("Not Prime") {
                    self.checkAnswer(isPrime: false)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 2)
            }
            //show result check mark or cross
            if let correct = isCorrect {
                Image(systemName: correct ? "checkmark.circle" : "xmark.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(correct ? .green : .red)
                    .padding(.top, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6))
        .alert(isPresented: $showDialog) {
            Alert(
                title: Text("Results"),
                message: Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)"),
                dismissButton: .default(Text("OK"), action: {
                    self.resetGame()
                })
            )
        }
        .onAppear {
            startTimer()
        }
    }
    //function to check if the number is prime
    func isPrimeNumber(_ n: Int) -> Bool {
        if n <= 1 { return false }
        if n == 2 { return true }
        for i in 2..<Int(sqrt(Double(n))) + 1 {
            if n % i == 0 { return false }
        }
        return true
    }
    //function to check users answer
    func checkAnswer(isPrime: Bool) {
        timer?.invalidate()
        if isPrime == isPrimeNumber(number) {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
        isCorrect = (isPrime == isPrimeNumber(number))

        if let correct = isCorrect {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(correct ? .success : .error)
        }

        attempts += 1

        if attempts >= 10 {
            showDialog = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.generateNewNumber()
            }
        }
    }
    //function to generate a new number
    func generateNewNumber() {
        number = Int.random(in: 1...1000)
        isCorrect = nil
        startTimer()
    }
    //function to start timer
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.wrongAnswers += 1
            self.isCorrect = false
            self.attempts += 1

            if self.attempts >= 10 {
                self.showDialog = true
            } else {
                self.generateNewNumber()
            }
        }
    }
    //function to reset game
    func resetGame() {
        correctAnswers = 0
        wrongAnswers = 0
        attempts = 0
        generateNewNumber()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




