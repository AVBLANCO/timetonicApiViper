//
//  UserEntity.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

//POST https://timetonic.com/live/api.php
//PARAMETERS version=1.47&req=createAppkey&appname=android

struct AppkeyRequest: Codable {
    let version: String
    let req: String
    let appname: String
}

struct AppkeyResponse: Codable {
    let status: String
    let appkey: String?
    let id: String?
    let createdVNB: String?
    let req: String?
}

struct OauthkeyRequest: Codable {
    let version: String
    let req: String
    let login: String
    let pwd: String
    let appkey: String
}

struct OauthkeyResponse: Codable {
    let status: String
    let id: String
    let o_u: String
    let createdVNB: String
    let oauthkey: String?
    let errorMsg: String?
}

struct SesskeyRequest: Codable {
    let version: String
    let req: String
    let o_u: String
    let u_c: String
    let oauthkey: String
}

struct SesskeyResponse: Codable {
    let status: String
    let sesskey: String?
    let errorMsg: String?
}

struct UserEntity : Decodable {
    var status : String
    var sstamp : Int
    var userInfo : [UserInfo]
    var createdVNB : String
    var req : String
}

struct UserInfo : Decodable {
    var firstTime : Bool
    var uimgStamp : Int
    var sstamp : Int
    var nbBooks : Int
    var u_c : Int
    var userPrefs : [UserPrefsBooks]
    var rights : [Rights]
    var colors : [Colors]
    var projectID : Int
    
}

struct UserPrefsBooks : Decodable {
    var mail1 : String
    var mail1_toConfirm : String
    var mob1 : String
    var sex : String
    var country : String
    var fname : String
    var lname : String
    var lang : String
    var UCREATEDON : String
    var birthd : String
    var mail2 : String
    var mail2_toConfirm : String
    var mob2 : String
    var address : String
    var zip : String
    var city : String
    var cie : String
    var vatn : String
    var account : String
    var until : String
    var slashd : Bool
    var regiondf : String
    var sdate : String
    var method : String
    var openGrand : Bool
    var NotifMobile : Bool
    var nbCol : Int
    var lastConnection : String
    var secondsSincePreviousConnection : String
    var tz : String
    var syncWithHubic : String
}

struct Rights: Codable {
    let formPro: Bool

    enum CodingKeys: String, CodingKey {
        case formPro = "form-pro"
    }
}

struct Colors: Codable {
    let defaut, bleuViolet, gray, bleuTurquoise: String
    let red, green, orange, pink: String
    let bleuNuit, noir, roseBois, orangePastel: String
    let vertPastel, jauneIndien, lilas: String

    enum CodingKeys: String, CodingKey {
        case defaut
        case bleuViolet = "bleu-violet"
        case gray
        case bleuTurquoise = "bleu-turquoise"
        case red, green, orange, pink
        case bleuNuit = "bleu-nuit"
        case noir
        case roseBois = "rose-bois"
        case orangePastel = "orange-pastel"
        case vertPastel = "vert-pastel"
        case jauneIndien = "jaune-indien"
        case lilas
    }
}

