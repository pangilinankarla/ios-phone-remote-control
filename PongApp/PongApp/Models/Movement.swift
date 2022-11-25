struct Movement: Codable {
  var roomId: String?
  var sessionId: String?
  var character: Character?
}

struct Character: Codable {
  var blendShape: BlendShape?
}
//{
//  roomId : 123abc,
//  sessionId : 123abc,
//  {
//    character : {
//      blendShape : BlendShape,
//      otherStuff : stff
//    }
//  }
//}
