Some powershell scripts to get Benjamin Moore paint colours from a set of RGB values. Note: This is only tested on the Canadian website

```
PS> Import-Module .\BenjaminMoore.psm1
# this takes a minute or two to avoid making too many API requests
PS> $data = Get-BenjaminmooreData
PS> Find-MatchingColours -data $data -r 235 -b 77 -g 126 -delta 10 | select PageUrl

pageUrl                                                                                      
-------                                                                                      
https://www.benjaminmoore.com/en-ca/colour-overview/find-your-colour/colour/084/fiesta-orange
https://www.benjaminmoore.com/en-ca/colour-overview/find-your-colour/colour/2169-30/oriole
```

Since you're unlikely to find exactly matching RGB values, use delta for a +/- allowance of values. For example, that search will find any
colours with red between 225-245, green between 116-136, and blue between 67-87 inclusive