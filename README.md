# windows-opsec-cleaner

#### this is made for automatic task schedulers to work with windows, to keep some privacy and protect your data on windows from unauthorized attackers, using this script you are agreed to script modify and delete files from your computer.
> [!NOTE]  
> This script can modify and delete permanently files from your computer, this is tested successfully at windows rdp 2024 server, windows rdp 2022 server, windows 11 pro, windows 10 pro without noticed system problems, bugs, crashs, games and other problems
> to be clear this is just cleaner history of your usage at pc.

### setup and basic usage

* Manually usage:
  * Simply right click and run as administrator the bat file
* Task Scheduler
  * Open Task Scheduler
  * Action -> Create a Basic Task
  * Put your task name whatever you want
  * Setup trigger when you log on at pc (When I log on)
  * Action - Select a Program
  * Now put .bat file in C:/ and select in prevous step that location
  * Check option open 'Properties dialog for this task when i click finish' and click finish
  * In 'Security Options' check 'Run with highest privileges'
  * Click OK, and test it, if is all good the prompt will showup when you log in at your pc (prompt will show only if you use default options)
* Options in script
  * https://github.com/zile42O/windows-opsec-cleaner/blob/54de8268db9abdacc5ef3ba215a6701779d4bcef/cleaner.bat#L14-L16
    * You can disable/enable variables or feel free to add more if you need.
