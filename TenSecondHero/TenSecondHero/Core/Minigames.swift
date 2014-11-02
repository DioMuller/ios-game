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
    static var Flap : Int = 0
    static var Shoot : Int = 1
    static var Run : Int = 2
    
    static var Count = 3
    
    static func getInfo(type : Int ) -> MinigameInfo {
        switch(type) {
        case Flap:
            return MinigameInfo(title: "Flap!", hero: HeroInfo(name: "Flying Hero", image: "flyinghero.png"))
        case Shoot:
            return MinigameInfo(title: "Explore Space!", hero: HeroInfo(name: "Space Hero", image: "spacehero_thumb.png"))
        case Run:
            return MinigameInfo(title: "Run!", hero: HeroInfo(name: "Running Hero", image: "runningirl_thumb.png"))
        default:
            return MinigameInfo(title: "Error!", hero: HeroInfo(name: "Wrong Hero", image: "hero_failure.png"))
        }
    }
}
