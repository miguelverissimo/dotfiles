alias nav='printf "\
|====================  $(tput sgr0)$(tput bold)$(tput setaf 3)MOVING$(tput sgr0)  =====================|
| $(tput bold)$(tput setaf 2)ctrl + a$(tput sgr0)   move to the $(tput setaf 1)beginning$(tput sgr0) of the line      |
| $(tput bold)$(tput setaf 2)ctrl + e$(tput sgr0)   move to the $(tput setaf 1)end$(tput sgr0) of the line            |
| $(tput bold)$(tput setaf 2)alt + b$(tput sgr0)    move one word $(tput setaf 1)back$(tput sgr0)                     |
| $(tput bold)$(tput setaf 2)alt + f$(tput sgr0)    move one word $(tput setaf 1)forward$(tput sgr0)                  |
|-------------------  $(tput sgr0)$(tput bold)$(tput setaf 3)DELETING$(tput sgr0)  --------------------|
| $(tput bold)$(tput setaf 2)ctrl + u$(tput sgr0)   delete to the $(tput setaf 1)beginning$(tput sgr0) of the line    |
| $(tput bold)$(tput setaf 2)ctrl + k$(tput sgr0)   delete to the $(tput setaf 1)end$(tput sgr0) of the line          |
| $(tput bold)$(tput setaf 2)ctrl + w$(tput sgr0)   delete one word $(tput setaf 1)back$(tput sgr0)                   |
| $(tput bold)$(tput setaf 2)alt + f$(tput sgr0)    delete one word $(tput setaf 1)forward$(tput sgr0)                |
|--------------------  $(tput sgr0)$(tput bold)$(tput setaf 3)OTHER$(tput sgr0)  ----------------------|
| $(tput bold)$(tput setaf 2)ctrl + xe$(tput sgr0)  $(tput setaf 1)edit$(tput sgr0) the current command interactively |
| $(tput bold)$(tput setaf 2)ctrl + l$(tput sgr0)   $(tput setaf 1)clear$(tput sgr0)                                  |
| $(tput bold)$(tput setaf 2)ctrl + -$(tput sgr0)   $(tput setaf 1)undo$(tput sgr0)                                   |
| $(tput bold)$(tput setaf 2)ctrl + r$(tput sgr0)   $(tput setaf 1)search$(tput sgr0) history                         |
| $(tput bold)$(tput setaf 2)ctrl + g$(tput sgr0)   $(tput setaf 1)cancel$(tput sgr0) search                          |
|===================================================|

"'
