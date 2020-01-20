Configuration PullDemo {
    Node ILCSDSC { # can list with scripblock or comma separated. 
        WindowsFeature Backup { # name of feature. Each will take a name. Only describes the State
            Ensure  = 'Present' # This will install. 
            Name    = 'Windows-Server-Backup'
        }
    }
}
PullDemo

# Each node you plan to manage can only be given a single config. 

Start-DscConfiguration -ComputerName ILCSDSC -Path C:\dsc\PullDemo

# pull server gives you high availability through IIS

# ARR / NLB / LB

# Pull   Pull
#     SAN

# Pull server Farm.
