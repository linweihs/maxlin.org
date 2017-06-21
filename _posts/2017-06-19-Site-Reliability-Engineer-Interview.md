---
title: Site Reliability Engineer Interview
layout: post
class: post
tags: interview SRE 
comments: true
---
## Site Reliability Engineer Interview Questions
I recall I was asked by _Linkedin_ in the techinal phone interview. Some times later, I see this again in other blogs. It seems like this is a typical question to jump start the interview with SRE positions. 

## Question 1: Fizz Buzz
Write a program that outputs the string representation of numbers from 1 to n.

But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.

**Example**:

```
n = 15,

Return:
[
    "1",
    "2",
    "Fizz",
    "4",
    "Buzz",
    "Fizz",
    "7",
    "8",
    "Fizz",
    "Buzz",
    "11",
    "Fizz",
    "13",
    "14",
    "FizzBuzz"
]
```

### Solution 
```java
public class Solution {
    public List<String> fizzBuzz(int n) {
        
        List<String> list = new ArrayList<String>();
        if (n < 1) return list;
        
        for(int i = 1; i <= n; i++){
            
            String str = "";
            
            if(i % 3 == 0 && i % 5 == 0){
                str += "FizzBuzz";
            }else if (i % 3 == 0){
                str += "Fizz";
            }else if (i % 5 == 0){
                str += "Buzz";
            }else{
                str += i;
            }
            
            list.add(str);
        }
        return list;
    }
}
```

## Question 2: Parse log and extract values 
It tests the knowledge of regex and hashtable.

```
Dec  3 00:02:54 Mac Google Chrome Helper[69194]: Couldn't set selectedTextBackgroundColor from default ()
Dec  3 00:03:05 Mac Safari[68992]: KeychainGetICDPStatus: keychain: -25300
Dec  3 00:03:05 Mac Safari[68992]: KeychainGetICDPStatus: status: off
Dec  3 00:03:06 Mac com.apple.xpc.launchd[1] (com.apple.WebKit.Networking.AC8ED90D-0AC0-4666-B213-8BE93DE51E8C[68993]): Service exited with abnormal code: 1
Dec  3 00:03:08 Mac WindowServer[68664]: CGXGetConnectionProperty: Invalid connection 20367
Dec  3 00:03:08 Mac garcon[68729]: host connection <NSXPCConnection: 0x7fc9d8f1eda0> connection from pid 68708 invalidated
Dec  3 00:03:08 Mac WindowServer[68664]: CGXGetConnectionProperty: Invalid connection 20367
```

Write a script which parses ```/var/log/messages``` and generates a CSV with two columns: **minute**,** number_of_messages** in sorted time order.

```
minute,number_of_messages
Dec  3 00:02,1
Dec  3 00:03,6
```
Extract the program name from the field between the hostname and the log message and output those values in columns.

```
minute,number_of_messages,Google Chrome Helper,Safari,com.apple.xpc.launchd,WindowServer,garcon
Dec  3 00:02,1,0,0,0,0
Dec  3 00:03,0,2,1,2,1
```

## Question 3: Employee Hierarchy Traverse
assume there is a REST API available at ```http://www.employee.com/api``` for accessing employee information The employee information endpoint is ```/employee/<id>``` Each employee record you retrieve will be a JSON object with the following keys:

* ```name``` refers to a String that contains the employee’s first and last name
* ```title``` refers to a String that contains the employee’s job title
* ```reports``` refers to an Array of Strings containing the IDs of the employee’s direct reports

Write a function that will take an employee ID and print out the entire hierarchy of employees under that employee. For example, suppose that Flynn Mackie’s employee id is '**A123456789**' and his only direct reports are Wesley Thomas and Nina Chiswick. If you provide '**A123456789**' as input to your function, you will see the sample output below.
        
```
Flynn Mackie - Senior VP of Engineering
  Wesley Thomas - VP of Design
    Randall Cosmo - Director of Design
      Brenda Plager - Senior Designer
  Nina Chiswick - VP of Engineering
    Tommy Quinn - Director of Engineering
      Jake Farmer - Frontend Manager
        Liam Freeman - Junior Code Monkey
      Sheila Dunbar - Backend Manager
        Peter Young - Senior Code Cowboy
```

### Solution 

Recursively iterate each employee and print out the information

```python
import requests
import json

def foo(id, depth):
    endpoint = "http://www.employee.com/api/employee/" + id 
    r = requests.get(endpoint)
    json_data = json.loads(r.json()) 
    space = ""
    for i in depth:
        space += " "
    print space + json_data['name'] + " - " + json_data['title']

    for employee in json_data['reports']:
        foo(employee, depth + 1)

id = "A123456789"
foo(A123456789, 0)
```
