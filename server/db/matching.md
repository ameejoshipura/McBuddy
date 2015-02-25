Matching API description
----
We will be using string datatypes to keep things simple for the prototype.

The following is the proposed DB schema for the matching algorithm:

##Table profiles:

`qbid (string)` - unique id used as key, link to associated profile in QB
`classlist (string)` - see below
`schedule (string)` - see below


###classlist data structure:

 e.g. "MATH363|COMP360|ECSE428". Classes separated by '|' characters. Any whitespace should be ignored, case insensitive

###schedule data structure:

 e.g. m = morning, a = afternoon, e = evening. Ignore whitespace, case-insensitive. stored as json

```json
"{
    "monday": "mae",
    "tuesday": "ma",
    "wednesday": "ma",
    "thursday": "",
    "friday": "",
    "saterday": "",
    "sunday": ""
}"
```
----

**Since this is just a prototype, it's safe to assume the strings will be well-formed. If there's a problem, just skip the match.**

###matching alg

The matching algorithm should work as follows:

Given a profile (i.e. one entry in the table, i.e. a pid, qbid, classlist, and schedule), compare the class list against the whole table and build a list of people who match on a class. Then, from that smaller match list, remove anybody whose schedules don't match. Then return a list of table entries.

For example, person A has class list "ECSE428|ECSE306" and is only available Monday mornings. Build a list of people who have either class ECSE428 or ECSE306 (or both) on their class lists, and call this built list "partial matches". Then, from the partial matches, remove anybody who isn't free Monday mornings. Then return that list.

###example usage :

```ruby
#class list
cl1 = ClassList.new('{"classlist":["ECSE306","ECSE428","ECSE321","MATH263"]}')
#schedule 
s1 = Schedule.new(('{"monday":"mae","tuesday":"ma","wednesday":"ma","thursday":"","friday":"","saterday":"","sunday":""}'))

#create a user 
# id , classes , schedule 
u1 = User.new(1,cl1,s1)

#perform the match
#uArr : an array of users such as u1
#"ECSE306" : the class to be matched
#userList : MatchedResult
userList = Matcher.match(u1, uArr , "ECSE306")

#a string of the result in json 
resultInJson = userList.toJson

# array of matched User excluding the user being searched
matchedUserArr = userList.getUserList

```