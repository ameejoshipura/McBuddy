#!/usr/local/bin/ruby

require 'json'

##class that takes an qbid and return a
##list of user that have a good match for his
class Matcher

	#TODO 
	#match the userid with the users in a
	#database and return a MatchedResult
	#
	def match(userid)
		return MatchedResult.new
	end

end

class MatchedResult

	#TODO
	#return an array of User
	def getUserList()
		return @users
	end

end

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

end

class Schedule
	def initialize(map)
		@scheduleMap = map
	end

	def self.jsonToScheduleMap(json)
		return Schedule.new(JSON.parse(json))
	end

	def getScheduleMap
		return @scheduleMap
	end

	def self.getSampleScheduleJsonStr
		return '{monday:"mae",tuesday:"ma",wednesday:"ma",thursday:"",friday:"",saterday:"",sunday:"",}'
	end
end


class ClassList

	def initialize (map)
		@classArr = map["classlist"]
	end

	#convert a json array to a hash table
	def self.jsonToClassList(jsonString)
		return ClassList.new(JSON.parse(jsonString))
	end

	#for testing purpose
	def self.getSampleJsonStr
		return '{"classlist":["ECSE306","ECSE428","ECSE321","MATH263"]}'
	end

	def getClassesArray
		return @classArr
	end
end

cl1 = ClassList.new('{"classlist":["ECSE306","ECSE428","ECSE321","MATH263"]}')
cl2 = ClassList.new('{"classlist":["ECSE306","ECSE428","COMP302","COMP202"]}')
cl3 = ClassList.new('{"classlist":["COMP302","COMP202"]}')

#TODO implement schedule
Schedule
