import Foundation

class QBank{
    var list = [Question]()
    
    init() {
        
        list.append(Question( questionText: "How’s your credit?", choiceA: "Awesome (850-750)", choiceB: "Good (750 - 670)", choiceC: "Okay (550-675)", choiceD: "Bad (560-390)", Aa: "excellent", Bb: "good", Cc: "medium", Dd: "poor"))
        
        list.append(Question( questionText: "How do you plan to use your card?", choiceA:"For convenience: I plan to pay off my balance every month", choiceB: "For budgeting: I want flexibility in my payments", choiceC: "For perks: I want to get the most out of my purchases", choiceD: "For emergencies: I won’t be using it often", Aa: "cashback", Bb: "zero_intro_apr", Cc: "cashback", Dd: "no_annual_fee"))
        
        list.append(Question( questionText: "Where’s your money going?", choiceA: "Gas and food", choiceB: "Shopping", choiceC: "Travel", choiceD: "Everywhere", Aa: "cashback", Bb: "cashback", Cc: "travel", Dd: "cashback"))
        
        list.append(Question( questionText: "How often do you travel?", choiceA: "Constantly", choiceB: "Every few months", choiceC: "A couple times each year", choiceD: "Rarely", Aa: "travel", Bb: "travel", Cc: "none", Dd: "none"))
        
//        list.append(Question( questionText: "Why do you travel?", choiceA: "For work", choiceB: "For pleasure", choiceC: "", choiceD: ""))
        
        list.append(Question( questionText: "Would you consider a card with an annual fee?", choiceA: "Yes", choiceB: "No", choiceC: "", choiceD: "", Aa: "none", Bb:"no_annual_fee", Cc: "none", Dd: "none"))
    }
    
    //    list.append(Question( questionText: "Which would you rather see?", choiceA: "The best card for me", choiceB: "Several options"))
    
}

