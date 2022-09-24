//
//  Constants.swift
//  Twittor
//
//  Created by Simon Peter Ojok on 24/09/2022.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USER = DB_REF.child("users")
