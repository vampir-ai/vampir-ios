//
//  Models.swift
//  VampÏr
//
//  Created by 60436 on 4/13/18.
//  Copyright © 2018 Spencer Crow. All rights reserved.
//

import Foundation
import ObjectMapper

final class Login:Mappable{
    var username:String?
    var password:String?
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        self.username <- map["username"]
        self.username <- map["password"]
    }
    
}
final class User{
    var id:String?
    var username:String?
    var firstName:String?
    var lastName:String?
    var password:String?
    var email:String?
    required init?(map: Map){
        mapping(map: map)
    }
    func mapping(map: Map){
        self.id <- map["id"]
        self.username <- map["username"]
        self.password <- map["password"]
        self.firstName <- map["firstName"]
        self.lastName <- map["lastName"]
        self.email <- map["email"]
    }
}

final class Token{

    var token:String?
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map){
        self.token <- map["token"]

    }
}

final class Message{
    
    var message:String?
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map){
        self.message <- map["message"]
        
    }
}

final class SessionId{
    var sessionId:String?
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map){
        self.sessionId <- map["sessionId"]
    }
}
