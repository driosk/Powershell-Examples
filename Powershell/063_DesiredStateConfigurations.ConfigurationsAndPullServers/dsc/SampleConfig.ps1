Configuration PullDemo {
	Node MEMBER2 {
		WindowsFeature Backup {
			Ensure = 'Present'
			Name   = 'Windows-Server-Backup'
		}
	}
}

PullDemo