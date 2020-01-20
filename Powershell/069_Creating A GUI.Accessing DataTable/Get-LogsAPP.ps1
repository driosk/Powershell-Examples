﻿#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: e2a23018-efae-476a-8240-7455c5f7a262
# Source File: C:\Users\DRIOSX\Documents\SAPIEN\PowerShell Studio\Files\CriticalSoltutionsLogs.psf
#------------------------------------------------------------------------

<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.148
     Generated on:       12/11/2019 9:25 AM
     Generated by:       driosx
    --------------------------------------------------------------------------------
    .DESCRIPTION
        GUI script generated by PowerShell Studio 2018
#>


#----------------------------------------------
#region Application Functions
#----------------------------------------------

#endregion Application Functions

#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Show-CriticalSoltutionsLogs_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$CriticalSolutionsLogs = New-Object 'System.Windows.Forms.Form'
	$groupboxLogList = New-Object 'System.Windows.Forms.GroupBox'
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

	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------

	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$CriticalSolutionsLogs.WindowState = $InitialFormWindowState
	}

	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonOK.remove_Click($buttonOK_Click)
			$buttonGetLogs.remove_Click($buttonGetLogs_Click)
			$labelThisWillQueryEventsF.remove_Click($labelThisWillQueryEventsF_Click)
			$CriticalSolutionsLogs.remove_Load($CriticalSolutionsLogs_Load)
			$CriticalSolutionsLogs.remove_Load($Form_StateCorrection_Load)
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
	$CriticalSolutionsLogs.ClientSize = '660, 542'
	$CriticalSolutionsLogs.FormBorderStyle = 'FixedDialog'
	$CriticalSolutionsLogs.MaximizeBox = $False
	$CriticalSolutionsLogs.Name = 'CriticalSolutionsLogs'
	$CriticalSolutionsLogs.Text = 'CriticalSolutionsNetwork'
	$CriticalSolutionsLogs.add_Load($CriticalSolutionsLogs_Load)
	#
	# groupboxLogList
	#
	$groupboxLogList.Controls.Add($buttonOK)
	$groupboxLogList.Controls.Add($checkboxNewest50)
	$groupboxLogList.Controls.Add($listLogNames)
	$groupboxLogList.Font = 'Microsoft Sans Serif, 10pt'
	$groupboxLogList.Location = '14, 185'
	$groupboxLogList.Margin = '5, 5, 5, 5'
	$groupboxLogList.Name = 'groupboxLogList'
	$groupboxLogList.Padding = '5, 5, 5, 5'
	$groupboxLogList.Size = '602, 204'
	$groupboxLogList.TabIndex = 3
	$groupboxLogList.TabStop = $False
	$groupboxLogList.Text = 'Select Log to Display'
	$groupboxLogList.UseCompatibleTextRendering = $True
	$groupboxLogList.Visible = $False
	#
	# buttonOK
	#
	$buttonOK.Location = '434, 38'
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
	$listLogNames.Size = '385, 33'
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
	#Show the Form
	return $CriticalSolutionsLogs.ShowDialog()

} #End Function

#Call the form
Show-CriticalSoltutionsLogs_psf | Out-Null
