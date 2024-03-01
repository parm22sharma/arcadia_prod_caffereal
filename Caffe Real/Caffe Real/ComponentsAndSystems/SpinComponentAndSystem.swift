//
//  SpinComponentAndSystem.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 4/18/23.
//

import SwiftUI
import RealityKit

struct SpinComponent: Component {
    var speed: Float
    var axis: SIMD3<Float>
    init(speed: Float = 1.0, axis: SIMD3<Float> = [0,1,0]) {
        self.speed = speed
        self.axis = axis
    }
}

struct SpinSystem: System {
    static let query = EntityQuery(where: .has(SpinComponent.self))

    init(scene: RealityKit.Scene) {}

    func update(context: SceneUpdateContext) {
        for entity in context.scene.performQuery(Self.query) {
            let comp: SpinComponent = entity.components[SpinComponent.self]!
            entity.setOrientation(.init(angle: comp.speed * Float(context.deltaTime), axis: comp.axis), relativeTo: entity)
        }
    }
}

