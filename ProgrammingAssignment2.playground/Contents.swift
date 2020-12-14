
import Foundation

// Part 1

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1

var studentsGroups: [String: [String]] = [:]


for record in studentsStr.components(separatedBy: "; ") {
	struct Pair {
		let name: String
		let group: String

		init(_ pairOfStrings: [String]) {
			name = pairOfStrings[0]
			group = pairOfStrings[1]
		}
	}

	let recordPair = Pair(record.components(separatedBy: " - "))

	if studentsGroups[recordPair.group] == nil {
		studentsGroups[recordPair.group] = [recordPair.name]
	} else {
		studentsGroups[recordPair.group]!.append(recordPair.name)
	}
}

for group in studentsGroups.keys {
	studentsGroups[group]!.sort()
}


print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 15, 15, 13, 10, 10, 10, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// My code begin

for group in studentsGroups.keys {
	studentPoints[group] = [:]

	for name in studentsGroups[group]! {
		studentPoints[group]![name] = []

		for point in points {
			studentPoints[group]![name]!.append(randomValue(maxValue: point))
		}
	}
}

// My code end

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// My code begin

for group in studentPoints.keys {
	sumPoints[group] = [:]

	for name in studentPoints[group]!.keys {
		sumPoints[group]![name] = studentPoints[group]![name]!.reduce(0, +)
	}
}

// My code end

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// My code begin

for group in sumPoints.keys {
	let sum = Float(sumPoints[group]!.values.reduce(0, +))
	let count = Float(sumPoints[group]!.count)

	groupAvg[group] = sum / count
}

// My code end

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// My code begin

for group in sumPoints.keys {
	passedPerGroup[group] = [String](sumPoints[group]!.filter({
		$0.value >= 60
	}).keys)
}

// My code end

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Капінус Артем": [5, 8, 15, 14, 10, 9, 7, 10, 11], "Чередніченко Владислав": [5, 6, 15, 11, 13, 9, 0, 7, 15], "Давиденко Костянтин": [5, 8, 15, 0, 10, 0, 7, 0, 0], "Науменко Павло": [0, 8, 0, 15, 13, 10, 0, 0, 0], "Гончар Юрій": [5, 0, 11, 15, 10, 10, 10, 9, 15]], "ІВ-72": ["Киба Олег": [0, 8, 15, 11, 13, 10, 10, 9, 0], "Овчарова Юстіна": [4, 8, 15, 15, 13, 10, 7, 10, 15], "Тимко Андрій": [5, 6, 14, 15, 13, 10, 10, 10, 0], "Бортнік Василь": [5, 8, 0, 15, 13, 10, 10, 10, 0]], "ІВ-71": ["Музика Олександр": [4, 8, 15, 0, 12, 10, 10, 10, 15], "Трудов Антон": [5, 0, 0, 14, 12, 10, 0, 9, 0], "Феофанов Іван": [5, 8, 14, 11, 12, 0, 10, 10, 15], "Корнійчук Ольга": [0, 8, 11, 14, 12, 7, 7, 10, 14], "Гуменюк Олександр": [5, 8, 14, 15, 10, 0, 7, 10, 15], "Андрющенко Данило": [4, 8, 15, 15, 13, 0, 10, 7, 0]]]
//
//["ІВ-73": ["Чередніченко Владислав": 81, "Гончар Юрій": 85, "Давиденко Костянтин": 45, "Капінус Артем": 89, "Науменко Павло": 46], "ІВ-72": ["Овчарова Юстіна": 97, "Тимко Андрій": 83, "Бортнік Василь": 71, "Киба Олег": 76], "ІВ-71": ["Музика Олександр": 84, "Корнійчук Ольга": 83, "Феофанов Іван": 85, "Гуменюк Олександр": 84, "Андрющенко Данило": 72, "Трудов Антон": 50]]
//
//["ІВ-72": 81.75, "ІВ-73": 69.2, "ІВ-71": 76.333336]
//
//["ІВ-73": ["Чередніченко Владислав", "Гончар Юрій", "Капінус Артем"], "ІВ-71": ["Гуменюк Олександр", "Корнійчук Ольга", "Андрющенко Данило", "Феофанов Іван", "Музика Олександр"], "ІВ-72": ["Бортнік Василь", "Тимко Андрій", "Овчарова Юстіна", "Киба Олег"]]


// Part 2

class TimeAY {

	// UInt maps to NSUInteger typedef from Objective-C Foundation framework
	var _hours: UInt
	var _minutes: UInt
	var _seconds: UInt

	init() {
		_hours = 0
		_minutes = 0
		_seconds = 0
	}

	init(_ hours: UInt, _ minutes: UInt, _ seconds: UInt) {
		_hours = hours
		_minutes = minutes
		_seconds = seconds

		if _seconds > 59 {
			_seconds -= 60
			_minutes += 1
		}

		if _minutes > 59 {
			_minutes -= 60
			_hours += 1
		}

		if _hours > 23 {
			_hours -= 24
		}
	}

	// Swift`s Date maps to Foundation`s NSDate
	init(date: Date) {
		let calendar = Calendar.current // gregorian?

		_hours = UInt(calendar.component(.hour, from: date))
		_minutes = UInt(calendar.component(.minute, from: date))
		_seconds = UInt(calendar.component(.second, from: date))
	}

	func stringify() -> String {
		let isAM = self._hours < 13

		let hours = String(isAM ? _hours : _hours - 12)
		let minutes = _minutes < 10 ? "0\(_minutes)" : String(_minutes)
		let seconds = _seconds < 10 ? "0\(_seconds)" : String(_seconds)

		return String(format: "%@:%@:%@ %@", hours, minutes, seconds, isAM ? "AM" : "PM")
	}

	// computed property, for convenience
	var string: String {
		get { stringify() }
	}

	func plus(_ other: TimeAY) -> TimeAY {
		var hours: UInt = 0
		var minutes: UInt = 0
		var seconds: UInt = 0

		seconds += _seconds + other._seconds
		if seconds > 59 {
			seconds -= 60
			minutes += 1
		}

		minutes += _minutes + other._minutes
		if minutes > 59 {
			minutes -= 60
			hours += 1
		}

		hours += _hours + other._hours
		if hours > 23 {
			hours -= 24
		}

		return TimeAY(hours, minutes, seconds)
	}

	func minus(_ other: TimeAY) -> TimeAY {
		var hours = Int(_hours)
		var minutes = Int(_minutes)
		var seconds = Int(_seconds)

		seconds -= Int(other._seconds)
		if seconds < 0 {
			seconds += 60
			minutes -= 1
		}

		minutes -= Int(other._minutes)
		if minutes < 0 {
			minutes += 60
			hours -= 1
		}

		hours -= Int(other._hours)
		if hours < 0 {
			hours += 24
		}

		return TimeAY(
			UInt(hours),
			UInt(minutes),
			UInt(seconds)
		)
	}

	static func + (left: TimeAY, right: TimeAY) -> TimeAY {
		return left.plus(right)
	}

	static func - (left: TimeAY, right: TimeAY) -> TimeAY {
		return left.minus(right)
	}
}

print()

let time_from_defaults = TimeAY()
print("default initializer: \(time_from_defaults.string)")

let time_from_parameters = TimeAY(24, 60, 00)
print("initializer with parameters: \(time_from_parameters.string)")

let time_from_date = TimeAY(date: Date())
print("initialize with Date object: \(time_from_date.string)")

print()

let time1 = TimeAY(23, 59, 59)
let time2 = TimeAY(12, 00, 01)

let result0 = time1 + time2

print(String(format: "%@ - %@ = %@", time1.string, time2.string, result0.string))

let time3 = TimeAY(00, 00, 00)
let time4 = TimeAY(00, 00, 01)

let result1 = time3 - time4

print(String(format: "%@ - %@ = %@", time3.string, time4.string, result1.string))

print()
