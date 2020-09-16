# Unit testing optimizations
It's Friday afternoon. 
You just deployed a new feature to your Salesforce Org
Something is clearly wrong with it.
Your users are complaining, your boss is calling you in panic. 
You have to fix it NOW.
You open the debug log, it's a simple mistake. 
You fix the error in your Apex class in a few seconds. 
You prepare the deployment package in less than 5 minutes. Awesome.
You wait for that package validation. 
[60 minutes later], your package is ready to go. 
Clearly not the Friday you wanted.

Sounds familiar? I know it happened to me. 
Package validation is sometimes longer than actually fixing the problem and while we have no control over components validation, we do have some sort of control over the unit testing part of it.
