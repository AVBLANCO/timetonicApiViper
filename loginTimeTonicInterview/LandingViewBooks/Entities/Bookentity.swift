//
//  Bookentity.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 14/04/24.
//

import Foundation

//"appkey": "TagU-yW1w-sq9K-Jhr5-NaIj-AfHp-8CYW"

struct BookModel {
    
    struct ListBookResponse: Decodable {
        let status: String
        let errorCode: String?
        let errorMsg: String?
        let sstamp: Int
        let allBooks: [BookInfo]
    }
    
    struct BookInfo: Decodable {
        let nbBooks: Int
        let nbContacts: Int
        let contacts: [ContactInfo]
        let books: [BookDetails]
    }
    
    struct ContactInfo : Decodable {
        var u_c : String
        var lastName : String
        var firstName : String
        var sstamp : Int
        var isConfirmed : Bool
    }
    
    struct BookDetails: Decodable {
        var accepted : Bool
        var archived : Bool
        var sstamp : Int
        var del : Bool
        var b_c : String
        var b_o : String
        var contact_u_c : String?
        var nbNotRead : Int
        var nbMembers : Int
        var members : [Members]
        var fpForm : [FpForm]
        var lastMsg : [LastMsg]
        var userPrefs : [UserPrefs]
        var ownerPrefs : [OwnerPrefs]
        var sbid : Int
        var lastMsgRead : Int
        var lastMedia : Int
        var favorite : Bool
        var order : Int
        
    }
    
    struct Members : Decodable {
        var u_c : String
        var invite : String
        var right : Int
        
    }
    
    struct FpForm : Decodable {
        var sfpid : Int
        var name : String
        var lastModified : Int
    }
    
    struct LastMsg : Decodable {
        var smid : Int
        var uuid : String
        var sstamp : Int
        var lastCommentId : Int
        var msgBody : String
        var msgBodyHtml : String
        var msgType : String
        var msgMethod : String
        var msgColor : String
        var nbComments : Int
        var pid : Int
        var nbMedias : Int
        var nbEmailCids : Int
        var nbDocs : Int
        var b_c : String
        var b_o : String
        var u_c : String
        var msg : String
        var del : Bool
        var created : Int
        var lastModified : Int
        var medias : [Medias]
        
        
    }
    
    struct Medias : Decodable {
        var id : Int
        var ext : String
        var originName : String
        var internName : String
        var size : Int
        var type : String
        var emailCid : String
        var del : Bool
        
    }
    
    struct UserPrefs : Decodable {
        var maxMsgsOffline : Int
        var syncWithHubic : Bool
        var uCoverLetOwnerDecide : Bool
        var uCoverColor : String
        var uCoverUseLastImg : Bool
        var uCoverImg : String
        var uCoverType : String
        var inGlobalSearch : Bool
        var inGlobalTasks : Bool
        var notifyEmailCopy : Bool
        var notifySmsCopy : Bool
        var notifyMobile : Bool
        var notifyWhenMsgInArchivedBook : Bool
        
    }
    
    struct OwnerPrefs : Decodable {
        var oCoverColor : String
        var oCoverUseLastImg : Bool
        var oCoverImg : String?
        var oCoverType : String
        var authorizeMemberBroadcast : Bool
        var acceptExternalMsg : Bool
        var title : String
        var notifyMobileConfidential : Bool
        
    }
    
}
