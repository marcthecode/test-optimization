# Unit testing optimizations

## Read this article and more on [Marc The Code](https://www.marcthecode.com)

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

## Apex Testing

We do our best to cover all possible edge cases with a complete set of unit tests, but mistakes happen.
The problem is the more tests we add, the longer that package validation process takes to run. How can we make it go faster while maintaining that coverage and safety that a good set of tests provide?
My approach is to prevent as many database operations as possible in your test classes.

### Step 1 - Remove Logic from your Triggers

Extracting business logic outside our handlers makes it easier to understand everything that is going on inside of it, but also makes it easier to design our code as reusable components.

### Step 2 - Remove queries from your business logic

By writing queries directly inside your business logic, it's impossible to execute your tests without going to the database, which we want to avoid.

### Step 3 - Test your querying separately

By isolating your queries from your business logic, you make your query logic reusable and testable.

## Results

### Before

-Test Execution Time  705 ms

-Test Execution Time  660 ms

-*Test Execution Time  535 ms*

-Test Execution Time  593 ms

### After (without insertion)

-Test Execution Time  73 ms

-*Test Execution Time  43 ms*

-Test Execution Time  28 ms

-Test Execution Time  45 ms

### After (with insertion)

-Test Execution Time  700 ms

-*Test Execution Time  497 ms*

-Test Execution Time  647 ms

-Test Execution Time  551 ms

The test execution time when keeping everything in memory is at least 10 times faster, and the changes required to make it possible in tests has no significant hit on performance even when performing database operations.

I am using my favorite trigger framework made by Kevin O'Hara and available on GitHub [Here](https://github.com/kevinohara80/sfdc-trigger-framework)
