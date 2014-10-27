//
//  Collisions.swift
//  TenSecondHero
//
//  Created by Diogo Muller on 10/27/14.
//  Copyright (c) 2014 Diogo Muller. All rights reserved.
//

struct Collisions {
    static let Level : UInt32 = 1 << 0
    static let Player : UInt32 = 1 << 1
    static let Obstacle : UInt32 = 1 << 2
    static let Enemy : UInt32 = 1 << 3
    static let Ground : UInt32 = 1 << 4
    
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
}
