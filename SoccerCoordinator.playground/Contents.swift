

//Create Data Structures for Players and Team info

var leagueRoster:[[String: String]] = []
var experiencedPlayers: [[String: String]] = []
var novicePlayers: [[String: String]] = []
var dragonsRoster:[[String: String]] = []
var sharksRoster:[[String: String]] = []
var raptorsRoster:[[String: String]] = []
var teams = [
    dragonsRoster,
    sharksRoster,
    raptorsRoster
]

// createPlayer is a function that loads players data params into dictionaries
func createPlayer(name: String, height: Float, experience: String, guardian: String){
    let player = [
        "name": name,
        "height": "\(height)",
        "experience": experience,
        "guardian": guardian,
        ]
    
    leagueRoster.append(player)
    
}

// Enter player data
createPlayer("Joe Smith", height: 42, experience: "Yes", guardian: "Jim and Jan Smith")
createPlayer("Jill Tanner", height: 36, experience: "Yes", guardian: "Clara Tanner")
createPlayer("Bill Bon", height: 43, experience: "Yes", guardian: "Sara and Jenny Bon")
createPlayer("Eva Gordon", height: 45, experience: "No", guardian: "Wendy and Mike Gordon")
createPlayer("Matt Gill", height: 40, experience: "No" , guardian: "Charles and Sylvia Gill")
createPlayer("Kimmy Stein", height: 41, experience: "No", guardian: "Bill and Hilary Stein")
createPlayer("Sammy Adams", height: 45, experience: "No", guardian: "Jeff Adams" )
createPlayer("Karl Saygan", height: 42, experience: "Yes", guardian: "Heather Bledsoe" )
createPlayer("Suzane Greenberg", height: 44, experience: "Yes", guardian: "Henrietta Dumas")
createPlayer("Sal Dali", height: 41, experience: "No", guardian: "Gala Dali")
createPlayer("Joe Kavalier", height: 39, experience: "No", guardian: "Sam and Elaine Kavalier")
createPlayer("Ben Finkelstein", height: 44, experience: "No", guardian: "Aaron and Jill Finkelstein")
createPlayer("Diego Soto", height: 41, experience: "Yes", guardian: "Robin and Sarika Soto")
createPlayer("Chloe Alaska", height: 47, experience: "No", guardian: "David and Jamie Alaska")
createPlayer("Arnold Willis", height: 43, experience: "No", guardian: "Claire Willis")
createPlayer("Phillip Helm", height: 44, experience: "Yes", guardian: "Thomas Helm and Eva Jones")
createPlayer("Les Clay", height: 42, experience: "Yes", guardian: "Wynonna Brown")
createPlayer("Herschel Krustofski", height: 45, experience: "Yes", guardian: "Hyman and Rachel Krustofski")


// The players are weighted by experience level and height.  sortByExperience is a function
// that places the experienced players in one array, and novice players in another.
func sortByExperience(){
    for player in leagueRoster{
        if (player["experience"] == "Yes"){
            experiencedPlayers.append(player)
        }else{
            novicePlayers.append(player)
        }
        
    }
    
    
}

// sortByHeight is a function that accepts an array of player dictionaries and uses nested for
// loops and selection sort to arrange the players by height (tallet to shortest).  The ! operator
// is used to cast the height String optional to a Float.  This returns a sorted by height array.
func sortByHeight(var roster: [[String:String]]) -> [[String:String]]{
    var newRoster = roster
    for index in 0...(roster.count - 2){
        
        var lowest = index
        var temp:[String:String]
        for insideIndex in (index + 1)...(newRoster.count - 1){
            var outside = newRoster[index]["height"]!
            var inside = newRoster[insideIndex]["height"]!
            var outsideToFloat = Float(outside)
            var insideToFloat = Float(inside)
            if (insideToFloat > outsideToFloat){
                temp = newRoster[index]
                newRoster[index] = newRoster[insideIndex]
                newRoster[insideIndex] = temp
            }
        }
    }
    return newRoster
    
}

// call sortByExperience to break players into experienced and novice arrays.
sortByExperience()

// sort the players in the two player arrays and replace existing arrays.
experiencedPlayers = sortByHeight(experiencedPlayers)
novicePlayers = sortByHeight(novicePlayers)

// sortLeagueRosterByHeight simply creates and returns a new full league roster that is sorted
// by experienced players in decending height, then novice players in decending height, leaving
// the most valuable player(the tallest experienced player) in the zeroth position, and the
// least valuable player (shortest novice player) in the last position.
func sortLeagueRosterByHeight()->[[String:String]]{
    var sortedRoster = [[String:String]]()
    for player in experiencedPlayers{
        sortedRoster.append(player)
    }
    for player in novicePlayers{
        sortedRoster.append(player)
    }
    return sortedRoster
}

// replace non-sorted leagueRoster with sorted leagueRoster.
leagueRoster = sortLeagueRosterByHeight()

// Draft Teams
// Here we use a snake system in drafting to ensure fairness amongst teams.  i.e. the order shifts
// from order 1, 2, 3 in the first round to 3, 2, 1 in the second round, etc.  Bools are used to
// decide whether the draft is in acending or decending order per round.
func draftTeams(){
    var counter = 0
    var forward = true
    while counter < leagueRoster.count{
        if(forward){
            leagueRoster[counter]["team"] = "Dragons"
            dragonsRoster.append(leagueRoster[counter++])
            leagueRoster[counter]["team"] = "Sharks"
            sharksRoster.append(leagueRoster[counter++])
            leagueRoster[counter]["team"] = "Raptors"
            raptorsRoster.append(leagueRoster[counter++])
            forward = false
            
        }else {
            leagueRoster[counter]["team"] = "Raptors"
            raptorsRoster.append(leagueRoster[counter++])
            leagueRoster[counter]["team"] = "Sharks"
            sharksRoster.append(leagueRoster[counter++])
            leagueRoster[counter]["team"] = "Dragons"
            dragonsRoster.append(leagueRoster[counter++])
            forward = true
        }
        
    }
}

// Draft the teams
draftTeams()

// averageHeight accepts a team Array and divides total player inches by amount to players to
// determine the average player height.  A message with the team name and height average
// is printed out.
func averageHeight(team:[[String:String]]){
    var totalHeight:Float = 0
    var teamName = team[0]["team"]!
    for player in team{
        var stringHeight:String
        stringHeight = player["height"]!
        var numberHeight = Float(stringHeight)!
        totalHeight += numberHeight
    }
    print("The average height on the \(teamName) roster is \(totalHeight/Float(team.count)) inches.")
}

// Call averageHeight functions to calculate and display average height for each team.
averageHeight(raptorsRoster)
averageHeight(sharksRoster)
averageHeight(dragonsRoster)

//Generate letter for parents
// printParentLetters uses a switch to determine team practice date and time.
func printParentLetters(){
    var date:Int
    var time:Int
    for player in leagueRoster{
        switch player["team"]!{
        case "Raptors":
            date = 18
            time = 1
        case "Sharks":
            date = 17
            time = 3
        default:
            date = 17
            time = 1
        }
        print("Dear \(player["guardian"]!), \n\(player["name"]!) is a member of the \(player["team"]!)!  Practice is on March \(date) at \(time)pm.  See you there!")
    }
}

printParentLetters()