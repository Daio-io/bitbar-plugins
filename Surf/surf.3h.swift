#!/usr/bin/env xcrun swift

import Foundation

let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: NSDate())
let cHour = dateComponents.hour

func getSurfData(requestUrl: String) -> NSDictionary {

  let url: NSURL = NSURL(string: requestUrl)!
  let request: NSURLRequest = NSURLRequest(URL: url)

  var response: NSURLResponse?
  do {
    let urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlData, options: .MutableContainers) as? NSDictionary {
      if let arr = jsonResult["response"] as? Array<NSDictionary> where arr.count > 0 {
        let results = arr[0] as NSDictionary
        return results
      }
      return NSDictionary()
    } else {
      return NSDictionary()
    }
  } catch _ {
      return NSDictionary()
  }
}

func getStartHour(cHour: Int) -> Int {
  if cHour > 22 {
    return 22
  }
  return cHour
}

func getEndHour(currentHour: Int) -> Int {
  let end = currentHour + 2
  if end > 24 || end == 0 {
    return 1
  }
  return end
}

let API_KEY = ""
let startHour = getStartHour(cHour)
let endHour = getEndHour(startHour)
let urlPath: String = "http://surf-query.herokuapp.com/?apikey=\(API_KEY)&spotid=1449&start=\(startHour)&end=\(endHour)"

let results = getSurfData(urlPath)

if results.count > 0 {
  let minSwell = results["minSwell"] as! Int
  let maxSwell = results["maxSwell"] as! Int
  let wind = results["wind"] as! Int
  let star = results["solidStar"] as! Int
  let fadedStar = results["fadedStar"] as! Int
  let time = results["time"] as! String

  print("Surf: (🕑\(time))  \(minSwell)-\(maxSwell)ft  \(wind)mph  \(star)🌟 \(fadedStar)⭐️|color=#00838f")
} else {
  print("Surf: No Data |color=#d50000")
}
