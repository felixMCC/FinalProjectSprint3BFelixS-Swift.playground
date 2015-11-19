//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


var str = "Sprint 2: Creating players w/ delays.\nFelix Sotres\n"
println(str)

//Control class handles control flow of program
class Control{
    //create objects for MVC paradigm
    var theModel = Model()
    var theView = View()
    
    //main program function
    func run()-> Void{
        //testing: Make sure I can reference the Model and View
        theModel.identify()
        theView.identify()
        
        //demonstrate random number generator works
        for var i = 0; i < 3; ++i{
            theView.printToUser("random number: \(theModel.randomNumber())")
        }
        theModel.createPlayers()
        theModel.delay(10){
            self.run2()
        }
    }
    
    //this function is used to regain program control after all delays
    func run2()-> Void{
        theView.printPlayerArray(theModel.getPlayerArray())
        theModel.createTeams(theModel.getPlayerArray().count)
        theView.printTeamArray(theModel.getTeamArray())
        
    }
    
    
}//end Control Class

//Model handles all data manipulation
class Model{
    //Class global variables
    
    //Date objects in order to get system time/date
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    var playerArray : [Player] = [Player]()         //array of player objects
    var teamArray : [Team] = [Team]()               //array of team objects
    var delayValue : Double = 0.0                   //holds delay value
    var rate = 0
    
    //construction method for Model
    init(){
        //null
    }
    
    func identify() -> Void{
        println("Im the Model!")
        
    }
    
    //delays execution on a closure (basically a timer delay)
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
    }
    
    //generates a random number based off the time
    func randomNumber() -> Int{
        //get current seconds
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let seconds = components.second
        
        //create seed for random number
        var seed: UInt32 = UInt32(seconds)
        //get random number based off seed (current minute)
        var randomNumber = arc4random_uniform(seed)
        return Int(randomNumber)
    }
    
    //generates a player rating value (how good they are) between 1 - 5
    func ratingValue()-> Int {
        var val = randomNumber()        //get a random number & temporarily store it
        //println("ratingValue() Random Number: \(val)") //testing
        
        //figure out a rating value between 1-5
        if (val < 10){
            return 1
        } else if (val > 9 && val < 33){
            return 3
        } else if (val > 32 && val < 40){
            return 5
        } else if (val > 39 && val < 50){
            return 2
        } else if (val > 49 && val < 61){
            return 4
        }else {
            return 1
        }
    }
    
    //creates players for game
    func createPlayers()->Void{
        var delay1 : Bool = true
        var delay2 : Bool = true
        var delay3 : Bool = true
        
        println("\nCreating Players using delay...")
        //create players
        
        playerArray.append( Player(name1: "Paco", rating1: ratingValue()))
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create player on after a delay
        delay(delayValue){
            //do nothing
            println("Delay 1")      //testing
            self.playerArray.append( Player(name1: "Alex", rating1: self.ratingValue()))
            delay1 = false
        }
        
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create next player after a delay
        delay(delayValue){
            //do nothing
            println("Delay 2")      //testing
            self.playerArray.append( Player(name1: "Emily", rating1: self.ratingValue()))
            delay2 = false
        }
        
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create next player after a delay
        delay(delayValue){
            //do nothing
            println("Delay 3")      //testing
            self.playerArray.append( Player(name1: "Priya", rating1: self.ratingValue()))
            delay3 = false
        }
        
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create next player after a delay
        delay(delayValue){
            //do nothing
            println("Delay 4")      //testing
            self.playerArray.append( Player(name1: "Danny", rating1: self.ratingValue()))
        }
        
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create next player after a delay
        delay(delayValue){
            //do nothing
            println("Delay 5")      //testing
            self.playerArray.append( Player(name1: "Angela", rating1: self.ratingValue()))
        }
        
        //delay is used so creating players arent so close in stats (dependent on secs)
        delayValue = Double(ratingValue())
        //create next player after a delay
        delay(delayValue){
            //do nothing
            println("Delay 6")      //testing
            self.playerArray.append( Player(name1: "Feihong", rating1: self.ratingValue()))
        }
        
        
        XCPSetExecutionShouldContinueIndefinitely() //force playground to pause to let asychronous work to finish
        
    }
    
    //returns the player array
    func getPlayerArray()-> [Player]{
        return playerArray
    }
    
    //creates array of teams
    func createTeams( nTeam : Int){
        
        for var cnt = 1; cnt <= nTeam; ++cnt{
            teamArray.append(Team(tNumber: cnt))
        }
    }
    
    //returns the team array
    func getTeamArray()-> [Team]{
        return teamArray
    }
    
}//end Model Class

//View handles all GUI elements
class View{
    init(){
        //null
    }
    
    func identify() -> Void{
        println("Im the View!")
    }
    
    func printToUser(message : String)-> Void{
        println(message)
    }
    
    func printPlayerArray(pArray : [Player])-> Void{
        for player in pArray{
            printToUser("Player Name: \(player.name)")
            printToUser("Player Rating: \(player.rating)")
            printToUser("Team: \(player.team)")
        }
    }
    
    func printTeamArray(tArray : [Team]) -> Void {
        for team in tArray{
            printToUser("Team Number Created: \(team.teamNumber)")
        }
    }
    
}//end View Model

//Player class to create players & their stats for the app
class Player{
    //Player class variables/attributes
    var name : String = ""              //holds a players name
    var rating : Int = 0                //players rating level (how good they are)
    var team : Int = 0                  //players team
    
    //initializing method (player does not start on a team
    init( name1 : String, rating1 : Int){
        self.name = name1
        self.rating = rating1
    }
    
    //initializing method (player starts on a team
    init( name1 : String, rating1 : Int, team1 : Int){
        self.name = name1
        self.rating = rating1
        self.team = team1
    }
    
}//end Player class

//Team class holds team info
class Team{
    //Team class variables
    //var name: String = ""                 //team name
    var teamNumber : Int = 0                //team number
    var numberOfPlayers: Int = 0            //number of players in team
    var playersFittingEvenly: Int = 0       //number of players fitting evenly in this team
    //var teamPlayerArray : [Player]        //holds players in an array
    
    init(tNumber : Int){
        //do nothing
        self.teamNumber = tNumber           //set team number
    }
    
    func increasePlayerCount(){
        numberOfPlayers += 1
    }
}

var runProgram = Control()
runProgram.run()
























