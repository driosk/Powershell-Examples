trap {
    $error[0]
    #either exit with continue or break
    # with break I will pass that $error[0] into calling scope. 
    # if running from shell nothing else after do-domthing will run and will pass
    # to the shell if it can handle it. 
    # Continue is the other option, will do the same but continue after do-something and execute do-somethingelse.
}

Do-Somthing
Do-SomethingElse
# now there's a terminating exeption
# yes now it will go back and do whatever was in the trap.

#Trap makes it difficult to figure out what went wrong. 

# Try can have separate error handling for each cmd. 
try {
    Do-Somthing
}
catch {
    
}
try {
    Do-SomethingElse
}
catch {
    
}

# Only time to use trap now is last ditch mechanizm to write event log about error. 

Do-this # Unexpected error. 

# what we do now is 
try {
    try {
        Do-Somthing
    }
    catch {
        
    }
    try {
        Do-SomethingElse
    }
    catch {
        
    }
}
catch{
    do-somethingnow # generic error to eventlog or whatever you want to do. 
}