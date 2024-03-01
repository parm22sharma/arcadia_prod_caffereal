//
//  FoodEntity.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 4/18/23.
//

import RealityKit
import SwiftUI

extension Entity {
    func createSpinComponent(speed: Float = 0) {
        self.components.set(SpinComponent(speed: speed))
        self.generateCollisionShapes(recursive: true)
    }
    
    func setSpinSpeed(speed: Float = 0){
        if var spinComp: SpinComponent = self.components[SpinComponent.self] {
            spinComp.speed = speed
            self.components[SpinComponent.self] = spinComp
        }
    }
    
    func enableParticleEmission(){
        if var comp: ParticleEmitterComponent = self.components[ParticleEmitterComponent.self] {
            comp.mainEmitter.birthRate = 30
            self.components[ParticleEmitterComponent.self] = comp
            return
        }
        for child in self.children {
            child.enableParticleEmission()
        }
    }
    
    func disableParticleEmission(){
        if var comp: ParticleEmitterComponent = self.components[ParticleEmitterComponent.self] {
            comp.mainEmitter.birthRate = 0
            self.components[ParticleEmitterComponent.self] = comp
            return
        }
        for child in self.children {
            child.disableParticleEmission()
        }
    }
}
//
//
//class FoodEntity: Entity {
//    
//    func update() {
//        // Set the speed of the Earth's rotation on it's axis.
//        if var rotation: SpinComponent = earth.components[RotationComponent.self] {
//            rotation.speed = configuration.speed
//            earth.components[RotationComponent.self] = rotation
//        }
//    }
//}

//    static func makeModel(name: String, filename: String? = nil, rotationSpeed: Float = 0) -> Entity {
//        
//        // An empirical value to counter the scaling in the USDZ files.
//        let modelScaleFactor: Float = 0.004
//        
//        let entity = Entity()
//        entity.name = name
//        entity.components.set(RotationComponent(speed: rotationSpeed))
//        
//        // Create a placeholder sphere.
//        let mesh = MeshResource.generateSphere(radius: radius)
//        var material = PhysicallyBasedMaterial()
//        material.baseColor = .init(tint: color)
//        let placeholder = ModelEntity(mesh: mesh, materials: [material])
//        entity.addChild(placeholder)
//        
//        // Load a model from file, if there is one with the same name.
//        Task {
//            do {
//                let model = try await Entity(named: filename ?? name)
//                model.setScale(SIMD3(repeating: modelScaleFactor), relativeTo: model)
//                entity.addChild(model)
//                entity.removeChild(placeholder)
//                entity.generateCollisionShapes(recursive: true)
//            } catch {
//                print("Failed to load entity: \(error.localizedDescription)")
//            }
//        }
//        
//        entity.generateCollisionShapes(recursive: true)
//        
//        return entity
//    }
//}
