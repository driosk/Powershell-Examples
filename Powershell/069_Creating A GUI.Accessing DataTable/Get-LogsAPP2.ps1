﻿#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: 1a60ceb9-9bf7-4c1a-a9f6-7b1a787e3cfd
# Source File: C:\Users\driosx.CRIT\Documents\SAPIEN\PowerShell Studio\Projects\Multiform\Multiform.psproj
#------------------------------------------------------------------------
<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.148
     Generated on:       12/11/2019 10:27 AM
     Generated by:       driosx
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2018
#>



#region Source: Startup.pss
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
[void][Reflection.Assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][Reflection.Assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
[void][Reflection.Assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.

    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.

    .NOTES
        Use this function to initialize your script and to call GUI forms.

    .NOTES
        To get the console output in the Packager (Forms Engine) use:
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)

	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)


	#--------------------------------------------------------------------------

	if((Show-CriticalSoltutionsLogs_psf) -eq 'OK')
	{

	}

	$script:ExitCode = 0 #Set the exit code for the Packager
}







#endregion Source: Startup.pss

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------


	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.

		.OUTPUTS
			System.String

		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		if ($null -ne $hostinvocation)
		{
			Split-Path $hostinvocation.MyCommand.path
		}
		else
		{
			Split-Path $script:MyInvocation.MyCommand.Path
		}
	}

	#Sample variable that provides the location of the script
	[string]$ScriptDirectory = Get-ScriptDirectory



#endregion Source: Globals.ps1

#region Source: CriticalSoltutionsLogs.psf
function Show-CriticalSoltutionsLogs_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$CriticalSolutionsLogs = New-Object 'System.Windows.Forms.Form'
	$groupboxLogList = New-Object 'System.Windows.Forms.GroupBox'
	$buttonShowLogPropertiesOnl = New-Object 'System.Windows.Forms.Button'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$checkboxNewest50 = New-Object 'System.Windows.Forms.CheckBox'
	$listLogNames = New-Object 'System.Windows.Forms.ComboBox'
	$buttonGetLogs = New-Object 'System.Windows.Forms.Button'
	$textboxComputerName = New-Object 'System.Windows.Forms.TextBox'
	$labelThisWillQueryEventsF = New-Object 'System.Windows.Forms.Label'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------

	$CriticalSolutionsLogs_Load={
		#TODO: Initialize Form Controls here

	}

	$labelThisWillQueryEventsF_Click={
		#TODO: Place custom script here

	}

	#region Control Helper Functions
	function Update-ComboBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ComboBox.

		.DESCRIPTION
			Use this function to dynamically load items into the ComboBox control.

		.PARAMETER ComboBox
			The ComboBox control you want to add items to.

		.PARAMETER Items
			The object or objects you wish to load into the ComboBox's Items collection.

		.PARAMETER DisplayMember
			Indicates the property to display for the items in this control.

		.PARAMETER Append
			Adds the item(s) to the ComboBox without clearing the Items collection.

		.EXAMPLE
			Update-ComboBox $combobox1 "Red", "White", "Blue"

		.EXAMPLE
			Update-ComboBox $combobox1 "Red" -Append
			Update-ComboBox $combobox1 "White" -Append
			Update-ComboBox $combobox1 "Blue" -Append

		.EXAMPLE
			Update-ComboBox $combobox1 (Get-Process) "ProcessName"

		.NOTES
			Additional information about the function.
	#>

		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ComboBox]
			$ComboBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]
			$DisplayMember,
			[switch]
			$Append
		)

		if (-not $Append)
		{
			$ComboBox.Items.Clear()
		}

		if ($Items -is [Object[]])
		{
			$ComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ComboBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ComboBox.Items.Add($obj)
			}
			$ComboBox.EndUpdate()
		}
		else
		{
			$ComboBox.Items.Add($Items)
		}

		$ComboBox.DisplayMember = $DisplayMember
	}
	#endregion

	$buttonGetLogs_Click={
		#TODO: Place custom script here
		$lognames = Get-EventLog -ComputerName ($textboxComputerName.Text) -List | Select-Object -ExpandProperty Log
		Update-ComboBox $listLogNames $lognames
		$groupboxLogList.Visible = $true
		$listLogNames.SelectedIndex = 0
	}

	$buttonOK_Click={
		#TODO: Place custom script here
		If ($checkboxNewest50.Checked)
		{
			$events = Get-EventLog -ComputerName ($textboxComputerName.Text) -LogName ($listLogNames.SelectedItem)	-Newest 50
		}
		else
		{
			$events = Get-EventLog -ComputerName ($textboxComputerName.Text) -LogName ($listLogNames.SelectedItem)
		}
		$events | Out-GridView
	}

	$buttonShowLogPropertiesOnl_Click={
		#TODO: Place custom script here
		$log = Get-EventLog -List -ComputerName ($textboxComputerName.Text) |
		Where-Object Log -EQ ($listLogNames.SelectedItem)
		Show-LogProperties_psf -Action $log.OverFlowAction -Days $log.MinimumRetentionDays $log.MaximumKilobytes -Logname ($listLogNames.SelectedItem)
	}

	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------

	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$CriticalSolutionsLogs.WindowState = $InitialFormWindowState
	}

	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:CriticalSoltutionsLogs_checkboxNewest50 = $checkboxNewest50.Checked
		$script:CriticalSoltutionsLogs_listLogNames = $listLogNames.Text
		$script:CriticalSoltutionsLogs_listLogNames_SelectedItem = $listLogNames.SelectedItem
		$script:CriticalSoltutionsLogs_textboxComputerName = $textboxComputerName.Text
	}


	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonShowLogPropertiesOnl.remove_Click($buttonShowLogPropertiesOnl_Click)
			$buttonOK.remove_Click($buttonOK_Click)
			$buttonGetLogs.remove_Click($buttonGetLogs_Click)
			$labelThisWillQueryEventsF.remove_Click($labelThisWillQueryEventsF_Click)
			$CriticalSolutionsLogs.remove_Load($CriticalSolutionsLogs_Load)
			$CriticalSolutionsLogs.remove_Load($Form_StateCorrection_Load)
			$CriticalSolutionsLogs.remove_Closing($Form_StoreValues_Closing)
			$CriticalSolutionsLogs.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$CriticalSolutionsLogs.SuspendLayout()
	$groupboxLogList.SuspendLayout()
	#
	# CriticalSolutionsLogs
	#
	$CriticalSolutionsLogs.Controls.Add($groupboxLogList)
	$CriticalSolutionsLogs.Controls.Add($buttonGetLogs)
	$CriticalSolutionsLogs.Controls.Add($textboxComputerName)
	$CriticalSolutionsLogs.Controls.Add($labelThisWillQueryEventsF)
	$CriticalSolutionsLogs.AutoScaleDimensions = '144, 144'
	$CriticalSolutionsLogs.AutoScaleMode = 'Dpi'
	$CriticalSolutionsLogs.ClientSize = '627, 526'
	$CriticalSolutionsLogs.FormBorderStyle = 'FixedDialog'
	$CriticalSolutionsLogs.MaximizeBox = $False
	$CriticalSolutionsLogs.Name = 'CriticalSolutionsLogs'
	$CriticalSolutionsLogs.Text = 'CriticalSolutionsNetwork'
	$CriticalSolutionsLogs.add_Load($CriticalSolutionsLogs_Load)
	#
	# groupboxLogList
	#
	$groupboxLogList.Controls.Add($buttonShowLogPropertiesOnl)
	$groupboxLogList.Controls.Add($buttonOK)
	$groupboxLogList.Controls.Add($checkboxNewest50)
	$groupboxLogList.Controls.Add($listLogNames)
	$groupboxLogList.Font = 'Microsoft Sans Serif, 10pt'
	$groupboxLogList.Location = '14, 185'
	$groupboxLogList.Margin = '5, 5, 5, 5'
	$groupboxLogList.Name = 'groupboxLogList'
	$groupboxLogList.Padding = '5, 5, 5, 5'
	$groupboxLogList.Size = '584, 291'
	$groupboxLogList.TabIndex = 3
	$groupboxLogList.TabStop = $False
	$groupboxLogList.Text = 'Select Log to Display'
	$groupboxLogList.UseCompatibleTextRendering = $True
	$groupboxLogList.Visible = $False
	#
	# buttonShowLogPropertiesOnl
	#
	$buttonShowLogPropertiesOnl.Location = '17, 208'
	$buttonShowLogPropertiesOnl.Margin = '4, 4, 4, 4'
	$buttonShowLogPropertiesOnl.Name = 'buttonShowLogPropertiesOnl'
	$buttonShowLogPropertiesOnl.Size = '552, 34'
	$buttonShowLogPropertiesOnl.TabIndex = 3
	$buttonShowLogPropertiesOnl.Text = 'Show Log Properties Only'
	$buttonShowLogPropertiesOnl.UseCompatibleTextRendering = $True
	$buttonShowLogPropertiesOnl.UseVisualStyleBackColor = $True
	$buttonShowLogPropertiesOnl.add_Click($buttonShowLogPropertiesOnl_Click)
	#
	# buttonOK
	#
	$buttonOK.Location = '392, 38'
	$buttonOK.Margin = '5, 5, 5, 5'
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = '125, 35'
	$buttonOK.TabIndex = 2
	$buttonOK.Text = 'OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True
	$buttonOK.add_Click($buttonOK_Click)
	#
	# checkboxNewest50
	#
	$checkboxNewest50.Font = 'Microsoft Sans Serif, 11pt'
	$checkboxNewest50.Location = '17, 122'
	$checkboxNewest50.Margin = '5, 5, 5, 5'
	$checkboxNewest50.Name = 'checkboxNewest50'
	$checkboxNewest50.Size = '385, 37'
	$checkboxNewest50.TabIndex = 1
	$checkboxNewest50.Text = 'Only get newest 50'
	$checkboxNewest50.UseCompatibleTextRendering = $True
	$checkboxNewest50.UseVisualStyleBackColor = $True
	#
	# listLogNames
	#
	$listLogNames.DropDownStyle = 'DropDownList'
	$listLogNames.Font = 'Microsoft Sans Serif, 10pt'
	$listLogNames.FormattingEnabled = $True
	$listLogNames.Location = '17, 38'
	$listLogNames.Margin = '5, 5, 5, 5'
	$listLogNames.Name = 'listLogNames'
	$listLogNames.Size = '350, 33'
	$listLogNames.TabIndex = 0
	#
	# buttonGetLogs
	#
	$buttonGetLogs.Location = '458, 116'
	$buttonGetLogs.Margin = '5, 5, 5, 5'
	$buttonGetLogs.Name = 'buttonGetLogs'
	$buttonGetLogs.Size = '125, 32'
	$buttonGetLogs.TabIndex = 2
	$buttonGetLogs.Text = 'Get Logs'
	$buttonGetLogs.UseCompatibleTextRendering = $True
	$buttonGetLogs.UseVisualStyleBackColor = $True
	$buttonGetLogs.add_Click($buttonGetLogs_Click)
	#
	# textboxComputerName
	#
	$textboxComputerName.Font = 'Microsoft Sans Serif, 11pt'
	$textboxComputerName.Location = '31, 116'
	$textboxComputerName.Margin = '5, 5, 5, 5'
	$textboxComputerName.Name = 'textboxComputerName'
	$textboxComputerName.Size = '408, 32'
	$textboxComputerName.TabIndex = 1
	#
	# labelThisWillQueryEventsF
	#
	$labelThisWillQueryEventsF.Font = 'Microsoft Sans Serif, 11pt'
	$labelThisWillQueryEventsF.Location = '31, 52'
	$labelThisWillQueryEventsF.Margin = '5, 0, 5, 0'
	$labelThisWillQueryEventsF.Name = 'labelThisWillQueryEventsF'
	$labelThisWillQueryEventsF.Size = '408, 59'
	$labelThisWillQueryEventsF.TabIndex = 0
	$labelThisWillQueryEventsF.Text = 'This will query Events from a Computer. Enter the Computer Name.'
	$labelThisWillQueryEventsF.UseCompatibleTextRendering = $True
	$labelThisWillQueryEventsF.add_Click($labelThisWillQueryEventsF_Click)
	$groupboxLogList.ResumeLayout()
	$CriticalSolutionsLogs.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $CriticalSolutionsLogs.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$CriticalSolutionsLogs.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$CriticalSolutionsLogs.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$CriticalSolutionsLogs.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $CriticalSolutionsLogs.ShowDialog()

}
#endregion Source: CriticalSoltutionsLogs.psf

#region Source: LogProperties.psf
function Show-LogProperties_psf
{
param
(
	[string]$Logname,
	[string]$MaxSize,
	[string]$Days,
	[string]$Action
)

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formLogProperties = New-Object 'System.Windows.Forms.Form'
	$textboxAction = New-Object 'System.Windows.Forms.TextBox'
	$textboxDays = New-Object 'System.Windows.Forms.TextBox'
	$textboxMaxSize = New-Object 'System.Windows.Forms.TextBox'
	$labelOverwriteAction = New-Object 'System.Windows.Forms.Label'
	$labelRetentionDays = New-Object 'System.Windows.Forms.Label'
	$labelMaxSize = New-Object 'System.Windows.Forms.Label'
	$labelLogName = New-Object 'System.Windows.Forms.Label'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------



	$formLogProperties_Load={
		#TODO: Initialize Form Controls here
		$labelLogName.Text 		= "Log: $Logname"
		$textboxAction.Text 	= $Action
		$textboxDays.Text 		= $Days
		$textboxMaxSize.Text	= $MaxSize
	}

	$buttonOK_Click={
		#TODO: Place custom script here
		$formLogProperties.Close()
	}

	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------

	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formLogProperties.WindowState = $InitialFormWindowState
	}

	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:LogProperties_textboxAction = $textboxAction.Text
		$script:LogProperties_textboxDays = $textboxDays.Text
		$script:LogProperties_textboxMaxSize = $textboxMaxSize.Text
	}


	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonOK.remove_Click($buttonOK_Click)
			$formLogProperties.remove_Load($formLogProperties_Load)
			$formLogProperties.remove_Load($Form_StateCorrection_Load)
			$formLogProperties.remove_Closing($Form_StoreValues_Closing)
			$formLogProperties.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formLogProperties.SuspendLayout()
	#
	# formLogProperties
	#
	$formLogProperties.Controls.Add($textboxAction)
	$formLogProperties.Controls.Add($textboxDays)
	$formLogProperties.Controls.Add($textboxMaxSize)
	$formLogProperties.Controls.Add($labelOverwriteAction)
	$formLogProperties.Controls.Add($labelRetentionDays)
	$formLogProperties.Controls.Add($labelMaxSize)
	$formLogProperties.Controls.Add($labelLogName)
	$formLogProperties.Controls.Add($buttonOK)
	$formLogProperties.AcceptButton = $buttonOK
	$formLogProperties.AutoScaleDimensions = '10, 20'
	$formLogProperties.AutoScaleMode = 'Font'
	$formLogProperties.CancelButton = $buttonOK
	$formLogProperties.ClientSize = '397, 301'
	$formLogProperties.FormBorderStyle = 'FixedDialog'
	$formLogProperties.Margin = '8, 8, 8, 8'
	$formLogProperties.MaximizeBox = $False
	$formLogProperties.MinimizeBox = $False
	$formLogProperties.Name = 'formLogProperties'
	$formLogProperties.StartPosition = 'CenterParent'
	$formLogProperties.Text = 'Log Properties'
	$formLogProperties.add_Load($formLogProperties_Load)
	#
	# textboxAction
	#
	$textboxAction.Enabled = $False
	$textboxAction.Location = '184, 162'
	$textboxAction.Margin = '5, 5, 5, 5'
	$textboxAction.Name = 'textboxAction'
	$textboxAction.Size = '164, 26'
	$textboxAction.TabIndex = 7
	#
	# textboxDays
	#
	$textboxDays.Enabled = $False
	$textboxDays.Location = '184, 124'
	$textboxDays.Margin = '5, 5, 5, 5'
	$textboxDays.Name = 'textboxDays'
	$textboxDays.Size = '164, 26'
	$textboxDays.TabIndex = 6
	#
	# textboxMaxSize
	#
	$textboxMaxSize.Enabled = $False
	$textboxMaxSize.Location = '184, 81'
	$textboxMaxSize.Margin = '5, 5, 5, 5'
	$textboxMaxSize.Name = 'textboxMaxSize'
	$textboxMaxSize.Size = '164, 26'
	$textboxMaxSize.TabIndex = 5
	#
	# labelOverwriteAction
	#
	$labelOverwriteAction.AutoSize = $True
	$labelOverwriteAction.Location = '15, 165'
	$labelOverwriteAction.Margin = '5, 0, 5, 0'
	$labelOverwriteAction.Name = 'labelOverwriteAction'
	$labelOverwriteAction.Size = '131, 24'
	$labelOverwriteAction.TabIndex = 4
	$labelOverwriteAction.Text = 'Overwrite Action'
	$labelOverwriteAction.TextAlign = 'MiddleRight'
	$labelOverwriteAction.UseCompatibleTextRendering = $True
	#
	# labelRetentionDays
	#
	$labelRetentionDays.AutoSize = $True
	$labelRetentionDays.Location = '24, 127'
	$labelRetentionDays.Margin = '5, 0, 5, 0'
	$labelRetentionDays.Name = 'labelRetentionDays'
	$labelRetentionDays.Size = '122, 24'
	$labelRetentionDays.TabIndex = 3
	$labelRetentionDays.Text = 'Retention Days'
	$labelRetentionDays.TextAlign = 'MiddleRight'
	$labelRetentionDays.UseCompatibleTextRendering = $True
	#
	# labelMaxSize
	#
	$labelMaxSize.Location = '40, 81'
	$labelMaxSize.Margin = '5, 0, 5, 0'
	$labelMaxSize.Name = 'labelMaxSize'
	$labelMaxSize.Size = '106, 35'
	$labelMaxSize.TabIndex = 2
	$labelMaxSize.Text = 'MaxSize'
	$labelMaxSize.TextAlign = 'MiddleRight'
	$labelMaxSize.UseCompatibleTextRendering = $True
	#
	# labelLogName
	#
	$labelLogName.Location = '22, 28'
	$labelLogName.Margin = '5, 0, 5, 0'
	$labelLogName.Name = 'labelLogName'
	$labelLogName.Size = '336, 35'
	$labelLogName.TabIndex = 1
	$labelLogName.Text = 'label1'
	$labelLogName.TextAlign = 'MiddleCenter'
	$labelLogName.UseCompatibleTextRendering = $True
	#
	# buttonOK
	#
	$buttonOK.Anchor = 'None'
	$buttonOK.DialogResult = 'OK'
	$buttonOK.Location = '223, 209'
	$buttonOK.Margin = '5, 5, 5, 5'
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = '125, 35'
	$buttonOK.TabIndex = 0
	$buttonOK.Text = '&OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True
	$buttonOK.add_Click($buttonOK_Click)
	$formLogProperties.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formLogProperties.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formLogProperties.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formLogProperties.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formLogProperties.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formLogProperties.ShowDialog()

}
#endregion Source: LogProperties.psf

#Start the application
Main ($CommandLine)
