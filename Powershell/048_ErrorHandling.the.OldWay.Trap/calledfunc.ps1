function do-something {
    get-thingy -computername BOB -erroraction stop

    trap {
        # not in scope because it needs to have seen it before the error. 
        # The error is unhandled and we return the error to the calling script. 
    }
}


# if not in a try block it will look for a trap defined in current scope. 