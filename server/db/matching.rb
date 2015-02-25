#!/usr/local/bin/ruby

require 'json'


class User 

	def initialize (id,classes,schedule)
		@QBId = id
		@classList = classes  
		@freeSchedule = schedule
	end

	def getQBId()
		return @QBId
	end

	def getClassList()
		return @classList
	end
	
	def getFreeSchedule()
		return @freeSchedule
	end

	def to_s()
		temp = ('{"id": ' + @QBId.to_s() << 
			',"schedule":' << @freeSchedule.getScheduleMap.to_s() << 
			',"classes": ' << @classList.getClassesArray.to_s) << '}'
		temp = temp.gsub "=>", ":"
		return temp

	end

class Schedule
	def initialize(map)
		@scheduleMap = JSON.parse(map)
	end

	def getScheduleMap
		return @scheduleMap
	end
end


class ClassList

	def initialize (map)
		@classArr = JSON.parse(map)["classlist"]
	end

	def getClassesArray
		return @classArr
	end
end


##class that takes an qbid and return a
##list of user that have a good match for his
class Matcher

	#TODO 
	#match the userid with the users in a
	#database and return a MatchedResult
	#
	def self.match(matchUser , userArray , matchClass)
		generalMatch = [] #users with the same class
		specificMatch = [] #users with same class and same free time
		#for search through the usersArray for a general match 
		userArray.each  do  |usr| 
			#for each class search if matchClass is present
			usr.getClassList.getClassesArray.each do |cls|
				if (matchClass == cls && (usr.getQBId != matchUser.getQBId)) then 
					generalMatch.push(usr)
					break 
				end
			end
		end
		#the matchUser's schedule
		matchSchedule = matchUser.getFreeSchedule().getScheduleMap

		days = ["monday", "tuesday" , "wednesday" , "thursday" , "friday" , "saterday" , "sunday"]
		generalMatch.each do |u|
			days.each do |d|
				#if there is an overlap time for the two users during a specific day then append to specificMatch and check next user
				if (levenshtein_distance(u.getFreeSchedule.getScheduleMap[d], matchSchedule[d]) != 0) then 
					specificMatch.push(u)
					break
				end 
			end
		end 

		return MatchedResult.new(specificMatch, generalMatch)

	end

	#used to compare schedule
	def self.levenshtein_distance(s, t)
		m = s.length
		n = t.length
		return m if n == 0
		return n if m == 0
		d = Array.new(m+1) {Array.new(n+1)}

		(0..m).each {|i| d[i][0] = i}
		(0..n).each {|j| d[0][j] = j}
		(1..n).each do |j|
			(1..m).each do |i|
      d[i][j] = if s[i-1] == t[j-1]  # adjust index into string
                  d[i-1][j-1]       # no operation required
              else
                  [ d[i-1][j]+1,    # deletion
                    d[i][j-1]+1,    # insertion
                    d[i-1][j-1]+1,  # substitution
                    ].min
                end
            end
        end
        d[m][n]
    end

end
 
class MatchedResult

	def initialize(specificMatch,generalMatch)
		@sm = specificMatch
		@gm = generalMatch
	end

	def toJson()
		temp = "{ \"specificMatch\" :"  + @sm.to_json + ' , "generalMatch" : ' + @gm.to_json + '}'
		temp = temp.gsub "\"{" , "{"
		temp = temp.gsub "}\"" , "}"
		return temp
	end

	#return an array of User
	def getGeneralArr()
		return @gm
	end

	def getSpecificArr()
		return @sm
	end

end


# cl1 = ClassList.new('{"classlist":["ECSE306","ECSE428","COMP302","MATH263"]}')
# cl2 = ClassList.new('{"classlist":["ECSE306","ECSE428","COMP302","COMP202"]}')
# cl3 = ClassList.new('{"classlist":["COMP302","COMP202"]}')

# # puts cl3.getClassesArray

# s1 = Schedule.new(('{"monday":"mae","tuesday":"ma","wednesday":"ma","thursday":"","friday":"","saterday":"","sunday":""}'))
# s2 = Schedule.new(('{"monday":"","tuesday":"","wednesday":"ma","thursday":"ae","friday":"ae","saterday":"","sunday":""}'))
# s3 = Schedule.new(('{"monday":"","tuesday":"","wednesday":"","thursday":"","friday":"ae","saterday":"","sunday":""}'))

# # puts s1.getScheduleMap()

# u1 = User.new(1,cl1,s1)
# u2 = User.new(2,cl2,s2)
# u3 = User.new(3,cl3,s3)

# uArr = [u1,u2,u3]
# uArr23 = [u2,u3]

# r1 = Matcher.match(u1,uArr23,"COMP302")
# r2 = Matcher.match(u2,uArr,"COMP302")

# # puts u1.to_json

# puts r2.toJson
# puts ""


# # puts u1.to_s 
# # puts u2.to_s 
# # puts u3.to_s 
# # puts u1.getFreeSchedule.getScheduleMap["monday"]

# # puts Matcher.levenshtein_distance("mae" , "mae")
# # puts Matcher.levenshtein_distance("mae" , "ma")
# # puts Matcher.levenshtein_distance("mae" , "m")
# # puts Matcher.levenshtein_distance("mae" , "")
# # puts Matcher.levenshtein_distance("mae" , "b")



end