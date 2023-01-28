let validEmployeeResponse =
"""
{
  "uuid": "0d8fcc12-4d0c-425c-8355-390b312b909c",
  "full_name": "John Doe",
  "phone_number": "18009991989",
  "email_address": "jdoe@square.com",
  "biography": "Engineer who loves the outdoors.",
  "photo_url_small": "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
  "photo_url_large": "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
  "team": "Restaurants",
  "employee_type": "FULL_TIME"
}
""".data(using: .utf8)!


let invalidEmployeeResponse =
"""
{
  "full_name": "John Doe",
  "phone_number": "18009991989",
  "email_address": "jdoe@square.com",
  "biography": "Engineer who loves the outdoors.",
  "photo_url_small": "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
  "photo_url_large": "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
  "team": "Restaurants",
  "employee_type": "FULL_TIME"
}
""".data(using: .utf8)!
