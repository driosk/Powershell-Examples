Configuration SetPullMode 
{

	Node MEMBER2
	{

		LocalConfigurationManager
		{

			ConfigurationMode = 'ApplyOnly'
			ConfigurationID = 'e528dee8-6f0b-4885-98a1-1ee4d8e86d82'
			RefreshMode = 'Pull'
			DownloadManagerName = 'WebDownloadManager'
			DownloadManagerCustomData = @{
				ServerUrl = 'http://pull1.lab.pri:8080/PSDSCPullServer.svc';
				AllowUnsecureConnection = 'true' }
			RefreshFrequencyMins = 5	

		}

	}

}

SetPullMode
Set-DSCLocalConfigurationManager -Computer MEMBER2 -Path ./SetPullMode -Verbose