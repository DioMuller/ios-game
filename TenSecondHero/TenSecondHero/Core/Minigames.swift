//
//  Minigames.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 11/2/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

import SpriteKit

struct HeroInfo {
    var name : String = String()
    var image : String = String()
    
    init(name : String, image : String){
        self.name = name
        self.image = image
    }
}

struct MinigameInfo {
    var title : String
    var hero : HeroInfo
    
    init(title : String, hero : HeroInfo){
        self.title = title
        self.hero = hero
    }
}



struct Minigames {
    static var MainGame : Int = -1
    
    static var Flap : Int = 0
    static var Space : Int = 1
    static var Run : Int = 2
    static var Shoot : Int = 3
    
    static var Count = 4
    
    static var initialized : Bool = false
    static var internalList : [MinigameInfo] = []
    
    static var list : [MinigameInfo] {
        get {
            if( !initialized ) {
                var i : Int = 0
                for( i = 0; i < Count; i++ ) {
                     internalList.append(Minigames.getInfo(i))
                }
                
                initialized = true
            }
            
            return internalList
        }
    }
    
    static var names :[String] {
        var namelist : [String] = []
        
        for info : MinigameInfo in Minigames.list {
            namelist.append(info.title)
        }
        
        return namelist
    }
    
    static var error : MinigameInfo {
        get {
            return MinigameInfo(title: "Error!", hero: HeroInfo(name: "Wrong Hero", image: "hero_failure.png"))
        }
    }
    
    static func getInfo(type : Int ) -> MinigameInfo {
        switch(type) {
        case Flap:
            return MinigameInfo(title: "Flap!", hero: HeroInfo(name: "Capeman", image: "flyinghero.png"))
        case Space:
            return MinigameInfo(title: "Explore Space!", hero: HeroInfo(name: "Captain Space", image: "spacehero_thumb.png"))
        case Run:
            return MinigameInfo(title: "Run!", hero: HeroInfo(name: "Runningirl", image: "runningirl_thumb.png"))
        case Shoot:
            return MinigameInfo(title: "Shoot!", hero: HeroInfo(name: "El Bandido", image: "thief01.png"))
        default:
            return error
        }
    }
    
    static func getInfo(name : String) -> MinigameInfo {
        for info : MinigameInfo in Minigames.list {
            if( name == info.title ){
                return info
            }
        }
        
        return error
    }
    
    
}
