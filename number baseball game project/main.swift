

let game = BaseballGame()
game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기

import Foundation

class BaseballGame {
    private var attempts: Int = 0
    private var answer: [Int] = []
    
    func start() {
        while true {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            guard let input = readLine(), let choice = Int(input) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            switch choice {
            case 1:
                self.attempts = 0
                self.answer = makeAnswer()
                print("< 게임을 시작합니다 >")
                playGame()
            case 2:
                print("게임 기록: \(self.attempts)번의 시도")
            case 3:
                print("게임을 종료합니다.")
                return
            default:
                print("올바르지 않은 선택입니다")
            }
        }
    }
    
    func makeAnswer() -> [Int] {
        var numbers = Array(0...9)
        numbers.shuffle()
        
        // 맨 앞자리에 0이 오지 않도록 조정
        if let index = numbers.firstIndex(of: 0) {
            numbers.swapAt(index, 1)
        }
        
        return Array(numbers.prefix(3))
    }
    
    func playGame() {
        while true {
            print("숫자를 입력하세요:")
            guard let input = readLine(), let guess = Int(input), input.count == 3 else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            let guessDigits = String(guess).compactMap { $0.wholeNumberValue }
            if !isValidInput(guessDigits) {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            self.attempts += 1
            let (strikes, balls) = checkGuess(answer: self.answer, guess: guessDigits)
            if strikes == 3 {
                print("정답입니다!")
                break
            } else {
                if strikes == 0 && balls == 0 {
                    print("Nothing")
                } else {
                    print("\(strikes)스트라이크 \(balls)볼")
                }
            }
        }
    }
    
    func isValidInput(_ digits: [Int]) -> Bool {
        let uniqueDigits = Set(digits)
        return digits.count == 3 && digits.count == uniqueDigits.count && digits[0] != 0
    }
    
    func checkGuess(answer: [Int], guess: [Int]) -> (Int, Int) {
        var strikes = 0
        var balls = 0
        
        for i in 0..<3 {
            if guess[i] == answer[i] {
                strikes += 1
            } else if answer.contains(guess[i]) {
                balls += 1
            }
        }
        
        return (strikes, balls)
    }
}
